---
layout: post
title: Puppet caching
github_username: daenney
twitter_username: daenney
date: 2014-05-20
---

With Puppet 3.6 out the door and the new caching mechanisms it provides I
started exploring how to do caching with Puppet. A thank you goes out to
[Ken Barber][kbarber] of [Puppet Labs][plabs] and [Erik Dalén][dalen] of
[Spotify][spotify] for their help on this quest.

The first thing I wanted to do is use the new caching mechanism for directory
based environments on Puppet 3.6 in such a way that our production environment
would be cached forever. Of course we also need a way to invalidate that cache
when we deploy but between two deploys this code never ever changes.

## Directory-based environments cache

First order of business, turn on caching in `/etc/puppet/puppet.conf`:

```ini
environment_timeout = unlimited
```

Restart the Puppet master and there you go. All the `*.pp` files are now parsed
once (instead of being reparsed every 5s or so). Problem is, how do we
invalidate this cache?

If you're running the 'community' stack all it takes is to tell Passenger to
reload. This can be done by simply touching the `tmp/restart.txt` file that
Passenger looks for. On the next request it receives, Passenger will reload and
the Puppet Master will now reparse the `*.pp` files for the environment.

The location of the `tmp/` directory varies but it's right next to where the
`config.ru` file is located:

```text
.
├── config.ru
├── public
└── tmp
    └── restart.txt
```

There is no need to remove the `restart.txt` file, Passenger looks at the
timestamp when a request comes in and makes the right decision.

If you're deploying with Capistrano you can override the `finalize_update` task
and add something like this in it:

```ruby
task :finalize_update do
    run "#{try_sudo} touch /usr/share/puppet/ext/rack/tmp/restart.txt"
end
```

## Nginx cache

The second thing I wanted to do is cache a few more things at the nginx level.
If you drill down a bit into Puppet you'll notice that one of the things the
agent does frequently is request things from the following endpoints:

* ``/$environment/file_metadata``
* ``/$environment/file_metadatas``
* ``/$environment/file_content``

These endpoints are computationally expensive; `file_metadata` for example ends
up running `md5sum` over every file that is being transferred and
`file_metadatas` does the same but in bulk for the plugins that are being
synced.

As you can imagine, `md5sum` over all these files constantly is slow and also
pretty useless as we just stated that these files don't change except for when
we deploy. Prime candidate for some fancy caching!

The first thing to do is configure the cache space itself in nginx. This *must*
be done in the [`http`][ngx-proxy-cache-path] block.

```nginx
proxy_cache_path /var/cache/nginx levels=1 keys_zone=puppetmaster:10m max_size=500m inactive=60m;
proxy_temp_path /var/cache/tmp;
```

What we've configured here is a cache space who's files will live in
`/var/cache/nginx`, have a directory structure of 1 level/folder deep, a
`key_zone` size of 10 megabytes, allowed to grow to 500 megabytes of disk space
and entries will be removed after 60 minutes if not being hit.

The `proxy_temp_path` is a filesystem location where temporary files that nginx
creates for its own purposes will live. It's a good idea for these directories
to be on the *same* filesystem.

Up next, configuring the actual cache for the proxy:

```nginx
location ~ ^/production/file_(metadatas?|content) {
        proxy_redirect             off;
        proxy_cache                puppetmaster;
        proxy_cache_valid          200 302 15m;
        proxy_cache_valid          404 1m;
        proxy_pass                 http://puppetmaster;
}
```

This block tells nginx to match certain paths in the request and proxy those to
the Puppet Master but by using the cache. A backend response of `200` or `302`
is cached for 15 minutes, a `404` is cached for 1m.

Notice that we're only matching `/production`, the production environment and
not any other. This is done on purpose, the other environments are usually for
testing that map to a feature-branch in git. We usually have no need to cache
these as they are short-lived.

A somewhat complete configuration looks like this:

```nginx
upstream puppetmaster {
    server unix:/path/to/passenger/puppetmaster/socket/file.sock;
}

server {
    listen              8140;
    root                /usr/share/puppet/ext/rack;
    ssl_certificate     /var/lib/puppet/ssl/certs/$FQDN.pem;
    ssl_certificate_key /var/lib/puppet/ssl/private_keys/$FQDN.pem;
    ssl_verify_client   optional;

    # All HTTP API requests, requiring a valid certificate
    location / {
        if ($ssl_client_verify != SUCCESS) {
            return 403;
            break;
        }
        proxy_set_header  X-Client-Verify  $ssl_client_verify;
        proxy_set_header  X-Client-DN      $ssl_client_s_dn;
        proxy_set_header  X-SSL-Subject    $ssl_client_s_dn;
        proxy_set_header  X-SSL-Issuer     $ssl_client_i_dn;
        proxy_redirect    off;
        proxy_pass        http://puppetmaster;
    }


    # Requests for cached endpoints, requiring a valid certificate
    location ~ ^/production/file_(metadatas?|content) {
        if ($ssl_client_verify != SUCCESS) {
            return 403;
            break;
        }
        proxy_cache_valid  200 302 15m;
        proxy_cache_valid  404 1m;
        proxy_pass         http://puppetmaster;
        proxy_set_header   X-Client-Verify  $ssl_client_verify;
        proxy_set_header   X-Client-DN      $ssl_client_s_dn;
        proxy_set_header   X-SSL-Subject    $ssl_client_s_dn;
        proxy_set_header   X-SSL-Issuer     $ssl_client_i_dn;
        proxy_redirect     off;
        proxy_cache        puppetmaster;
    }

    # Requests for /certificate, used before a valid certificate
    # has been recieved, therefor not requiring $ssl_client_verify
    location /certificate {
        proxy_redirect    off;
        proxy_pass        http://puppetmaster;
    }
}
```

Reload your nginx configuration and enjoy. Keep in mind that this cache will
not speed up agent run times but will mostly decrease load on your masters.

We are left with one problem though; how do we invalidate this cache at deploy
time? Throwing away the cache is pretty easy, just remove all files in
`/var/cache/nginx` and you're done. Trouble is, you probably don't have the
permissions to do so and you probably don't want to be `sudo`ing during your
deploy to do so.

Enter mod_lua for nginx. This allows us to create an endpoint on the Puppet
Master vhost that we can hit, simply with cURL, which will take care of
throwing away the cache. Beware that this is a hack, albeit an awesome one:

```nginx
location /cache_purge {
    limit_except POST {
        allow 127.0.0.1;
        allow ::1;
        deny all;
    }
    content_by_lua '
        os.execute("find /var/cache/nginx -type f -delete")
        ngx.status = 204
    ';
}
```

I'm sure you can guess what this does. You can now post to `/cache_purge` which
in turn, by using the power of Lua, executes the necessary command to clear up
the cache.

Going back to the Capistrano example earlier you can now add this too:

```ruby
task :finalize_update do
    run "#{try_sudo} touch /usr/share/puppet/ext/rack/tmp/restart.txt"
    run 'curl --silent -k -X POST https://localhost:8140/cache_purge'
end
```

I personally frown on the `-k` in the cURL command here so I suggest you
alter it to include `--cacert` and point that to
`/var/lib/puppet/ssl/certs/ca.pem` instead.

## Apache cache

The cache configuration for nginx is inspired based on what [Erik Dalén][dalen]
has been doing at Spotify and decided to share:

<script src="https://gist.github.com/dalen/6672186.js"></script>

Note that this configuration is not caching the `file_metadatas` endpoint, I
suggest you do. It also expires the cache after 300 seconds, 5m, and can grow
up to 1GB.

I'm familiar enough with Apache to be able to tell you that this stores the
cache in RAM but I have no idea how to invalidate it at deploy time.

[kbarber]: https://github.com/kbarber "Github - Ken Barber"
[plabs]: http://www.puppetlabs.com "Puppet Labs"
[dalen]: https://github.com/dalen "Github - Erik Dalén"
[spotify]: http://www.spotify.com "Spotify"
[ngx-proxy-cache-path]: http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_cache_path "NGINX - proxy_cache_path"
