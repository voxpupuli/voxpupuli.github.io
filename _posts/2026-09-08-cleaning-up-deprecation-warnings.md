---
date: 2026-09-08
github_username: corporate-gadfly
layout: post
title: "Cleaning Up Deprecation Warnings in OpenVox Modules: Facter::Util::Resolution.exec and .which"
---

As part of the upcoming **OpenVox Agent 9.0** release, a number of long-deprecated Facter APIs are being prepared for removal in a subsequent release, including `Facter::Util::Resolution.which` and `Facter::Util::Resolution.exec`. If you use OpenVox (or legacy Puppet) modules with custom facts, you will start seeing warnings like these in your output when running `facter` (OpenFact 6.x) with OpenVox 9.x:

```
Facter::Util::Resolution.which is deprecated and will be removed in a future major version. Use Facter::Core::Execution.which instead.
Facter::Util::Resolution.exec is deprecated and will be removed in a future major version. Use Facter::Core::Execution.execute instead.
```

These come straight out of `lib/facter/custom_facts/util/resolution.rb`:

```ruby
class << self
  # @deprecated Use Facter::Core::Execution.which instead
  # @api public
  def which(bin)
    Facter.warnonce('Facter::Util::Resolution.which is deprecated and will be removed in a future major version. ' \
                    'Use Facter::Core::Execution.which instead.')
    Facter::Core::Execution.which(bin)
  end

  # @deprecated Use Facter::Core::Execution.exec instead
  # @api public
  def exec(command)
    Facter.warnonce('Facter::Util::Resolution.exec is deprecated and will be removed in a future major version. ' \
                    'Use Facter::Core::Execution.execute instead.')
    Facter::Core::Execution.execute(command, on_fail: nil)
  end
```

Both methods still work today — they're thin wrappers that forward to their replacements — but they'll be removed in a future major release. The fix is mechanical, with one important behavioral nuance worth understanding before you blindly find-and-replace.

If you want to see where this API is still showing up in real-world code, take a look at this live GitHub search across voxpupuli modules: [`Facter::Util::Resolution` in voxpupuli code](https://github.com/search?q=org%3Avoxpupuli+%22Facter%3A%3AUtil%3A%3AResolution%22+path%3A%2F%5Elib%5C%2Ffacter%5C%2F%2F&type=code). It is a moving target, but it gives a useful snapshot of the remaining module updates that may be needed.

## The fix

Wherever your custom facts use the old API:

```ruby
Facter.add(:my_fact) do
  confine { Facter::Util::Resolution.which('some_binary') }
  setcode { Facter::Util::Resolution.exec('some_binary --version') }
end
```

...swap in the new module:

```ruby
Facter.add(:my_fact) do
  confine { Facter::Core::Execution.which('some_binary') }
  setcode { Facter::Core::Execution.execute('some_binary --version') }
end
```

That's it for the mechanical part. `which` is a drop-in rename. `exec` maps to `execute`.

## The nuance: `execute` already does a `which` for you

This is the part that trips people up. `Facter::Core::Execution.execute` doesn't just shell out blindly — internally it calls `expand_command`, which resolves the executable to an absolute path using the exact same `which` logic before running anything:

```ruby
def expand_command(command)
  exe, args = ...
  return unless exe && (expanded = which(exe))
  ...
end
```

And `execute`'s default behavior when that lookup comes back empty is to **raise**:

```ruby
def execute(command, options = {})
  on_fail, expand, logger, timeout = extract_options(options)
  expanded_command = expand ? expand_command(command) : command

  if expanded_command.nil?
    if on_fail == :raise
      raise Facter::Core::Execution::ExecutionFailure.new,
            "Could not execute '#{command}': command not found"
    end
    return on_fail
  end
  ...
end
```

So if the binary isn't found on `PATH`, `execute` will throw an `ExecutionFailure` by default — unless you pass `on_fail:` with something other than `:raise` (the old `exec` wrapper passed `on_fail: nil`, which is why it quietly returned `nil` on a missing binary instead of blowing up).

**The practical implication:** if your fact's `setcode` block calls `execute` without `on_fail: nil` (or another fallback value), a host that simply doesn't have the binary installed will raise an exception during fact resolution instead of the fact quietly evaluating to `nil`. That's a meaningfully different failure mode than what most existing modules expect from a custom fact.

## Prefer confining with `which` over relying on `execute`'s internal check

Because `execute` already performs the `which` lookup for you as part of expanding the command, it's tempting to skip the `confine` block entirely. But that also means `execute` can still raise if the binary is missing, so if you do not want non-existing binaries to fail resolution, it is preferable to perform a `confine` operation with `which` up front. It's cleaner — and more idiomatic for Facter — to keep an explicit `confine` that checks for the binary's existence with `which`, and let `setcode` assume the binary is present:

```ruby
Facter.add(:my_fact) do
  confine { Facter::Core::Execution.which('some_binary') }
  setcode { Facter::Core::Execution.execute('some_binary --version') }
end
```

Why this is the better pattern:

- **Intent is explicit.** Anyone reading the fact immediately sees the precondition for it to resolve at all, rather than having to know that `execute` silently swallows missing-binary errors.
- **The fact doesn't even attempt resolution on unsuitable hosts.** `confine` short-circuits the whole resolution, which is both faster and avoids relying on exception-swallowing behavior deep inside `execute`.
- **You avoid accidentally relying on `on_fail: nil` as a substitute for proper suitability checks.** If you forget the `on_fail:` option somewhere else in the same fact (e.g., a second `execute` call for a related command), you'll get a hard failure instead of a graceful `nil` — confining up front means that risk doesn't exist in the first place.
- **It matches how the rest of Facter's ecosystem expects facts to behave:** unsuitable systems shouldn't attempt resolution, not "attempt and fail softly."

## Summary

- `Facter::Util::Resolution.which` → `Facter::Core::Execution.which` (straight rename, no behavior change).
- `Facter::Util::Resolution.exec` → `Facter::Core::Execution.execute(command, on_fail: nil)` — remember the `on_fail: nil`, since `execute`'s default is to raise on a missing binary.
- Even though `execute` performs its own internal `which` check via `expand_command`, keep (or add) an explicit `confine { Facter::Core::Execution.which('binary') }` block rather than leaning on `execute`'s soft-fail behavior. It keeps your fact's suitability logic explicit, readable, and resilient to future changes in `execute`'s defaults.

Making this change now, ahead of **OpenVox Agent 9.0**, resulting in removing these deprecation warnings, is a small, low-risk update — and cleaning up the `confine`/`setcode` split at the same time will make your OpenVox modules more robust in the long run. In a future upgrade, modules that don't migrate will see their custom facts break outright once `Facter::Util::Resolution.which` and `.exec` are gone, so it's worth auditing your fact code now rather than waiting for the upgrade to force the issue.
