---
date: 2026-07-22
excerpt: The g10k README's fork rationale and benchmark are a decade old. I checked the claims against current r10k and re-ran the numbers on modern versions of both.
github_username: miharp
layout: post
title: "Revisiting the g10k benchmark: is r10k still slow, ten years later?"
---

If you've ever looked at the [g10k README](https://github.com/voxpupuli/g10k#why-fork),
you might have seen the "Why fork?" section. It lists three reasons the project split
off from r10k back in 2016:

* Lack of caching/version-pre-checking in r10k hurt performance beyond a
  certain number of modules per Puppetfile
* The need for distinct SSH keys per source, which rugged never wanted to
  play nice with
* A good excuse to try Go ;)

That section (and the benchmark next to it showing r10k taking 74 seconds
where g10k took 5) is now about a decade old, and I was curious how much of
it still holds up. So I checked the claims against the current r10k codebase
and re-ran the original benchmark on modern versions of both tools. The
results surprised me a bit.

## Checking the claims

The SSH key one is easy: the README itself admits it was fixed in r10k
2.2.0, and it still is. Current r10k supports per-remote `private_key`,
`oauth_token`, and even GitHub App credentials under `git.repositories`
(with the caveat that per-repo keys only apply to the rugged provider; on
the default shellgit provider you'd reach for `~/.ssh/config` instead).

The caching claim is only half true. r10k actually did cache git repos
as bare mirrors even back then, and today it also pre-checks versions all
over the place: it skips fetching entirely when a requested tag or commit is
already resolvable in the cache, skips checkouts when the working copy
already matches, and skips Forge downloads when the installed
`metadata.json` version is the expected one.

The real bottleneck in 2016 was that r10k did everything serially, one
module at a time. That changed in r10k 3.3.0 (2019), which introduced
concurrent module installation with a thread pool (`pool_size`, default 4).

As for the third claim, can't argue with "good excuse to try Go". That one
has aged just fine.

## Re-running the benchmark

The original benchmark used a
[Puppetfile with 4 git repos and 25 Forge modules](https://github.com/xorpaul/g10k-environment/blob/benchmark/Puppetfile).
All 29 modules still resolve in 2026, though the Forge prints a lot of
deprecation warnings along the way.

I ran the exact same Puppetfile through r10k 5.0.3 (Ruby 3.4.8, default
settings) and g10k v0.9.10 (default settings) on an Apple M2 Pro. Three runs
each, cold cache (cache dir and module dir wiped before every run) and warm:

{: .table .table-striped .table-hover }
| tool | cold cache | warm cache |
| --- | --- | --- |
| r10k 5.0.3 | 4.9s, 4.4s, 4.7s | 1.2s, 1.1s, 1.2s |
| g10k 0.9.10 | 3.5s, 3.5s, 2.9s | 0.5s, 0.5s, 0.4s |
| *2016 README* | *r10k ~74s vs g10k ~5s* | *r10k ~18s vs g10k ~1s* |

The hardware is obviously different from the 2016 Dell R320, so the ratios
are what matter: the roughly 15x gap from 2016 is down to about 1.4x cold
and 2.6x warm. A good chunk of what's left on warm runs is just Ruby
interpreter startup.

I did hit one gotcha: the benchmark Puppetfile declares its `aws` module
with no `:ref` at all. g10k quietly assumes `master`, but r10k 4+ refuses
to guess and errors out until you set `git.default_ref`. That's arguably
the safer behavior, but worth knowing if you migrate between the two.

## So which one should you use?

Both of the fork's concrete complaints were fixed in r10k years ago. What's
left comes down to the runtimes themselves.

g10k still gets you a single static binary, which means no Ruby stack on
your server and no interpreter startup on every webhook-triggered deploy.
Its parallelism defaults are also way more aggressive (50 resolve and 20
extract goroutines against r10k's 4 threads), and it parallelizes across
environments, which r10k still deploys one at a time.

How big a deal that last one is depends entirely on **how many branches
your control repo has**, and the single-Puppetfile benchmark above never
shows it. So I
built a second one: a local control repo with 50 branches, each containing the same
Puppetfile, deployed as a full environment sync (`r10k deploy environment
--modules` against a sources config, g10k with the equivalent config file).

{: .table .table-striped .table-hover }
| tool | cold cache | warm cache |
| --- | --- | --- |
| r10k 5.0.3 | 84.3s, 83.4s | 23.0s, 23.0s, 23.1s |
| g10k 0.9.10 | 48.5s, 48.0s | 1.7s, 1.6s, 1.7s |

Cold runs stay surprisingly close (about 1.7x), because both tools spend
most of that time writing 1450 module copies to disk. Warm runs are a
different story. r10k walks the 50 environments in a plain loop, and its
`pool_size` threads only help within each one, so even a no-op deploy takes
23 seconds. g10k spreads its whole worker pool across all environments at
once and is done in under two. The shared git cache takes some of the sting
out for r10k (each module repo is fetched once no matter how many
environments use it), but the checkouts and Forge version checks still
happen one environment at a time. If you run a control repo with lots of
long-lived branches and deploy on every push, this is where g10k still
earns its keep.

On the other side, r10k has the bigger feature surface: SVN and tarball
sources, GitHub App auth, module filtering, PE integration. It's also the
reference implementation, so Puppetfile semantics are whatever r10k says
they are. And if you want to manage the tool itself with Puppet, r10k is
the one with a well-supported module: [puppet/r10k](https://forge.puppet.com/modules/puppet/r10k)
is at 1.2 million downloads and still getting regular releases (from this
very community, in a funny twist). g10k has
[a third-party module](https://forge.puppet.com/modules/landcareresearch/g10k)
at a tenth of the downloads.

For a single Puppetfile, the performance difference has gone from
"grab a coffee" to "blink", and it only starts to matter again once your
control repo grows past a dozen or so branches. Use whichever fits your
infrastructure. Just base the decision on numbers from this decade.

Want to check my numbers? Both benchmarks are reproducible in a temp
directory with nothing but Ruby, git, and a g10k release binary, and I've
written up the exact steps in
[this gist](https://gist.github.com/miharp/15c3b3bc2a2b8bfc83089acfcb98b704).
I'd love to see numbers from other platforms.
