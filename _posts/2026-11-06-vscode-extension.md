---
date: 2026-11-06
github_username: rwaffen
excerpt: We have released an extension for OpenVox for Visual Studio Code and VSCodium.
layout: post
title: "🚀 OpenVox for VS Code: Now Available!"
---

Hey everyone! 👋

I'm happy to announce that our **OpenVox extension for Visual Studio Code and VSCodium** is officially available on both the VS Code Marketplace and Open VSX! 🎉

The extension aims to make developing with OpenVox a smoother and more enjoyable experience, with language support directly in your favorite editor.

But how did we get here? Well, it all started with a little frustration. 😅

## From Frustration to a Fresh Start 🔧

For quite some time, I hadn't been particularly happy with the existing Puppet VS Code extension. One of my biggest annoyances was its dependency on the Puppet Development Kit (PDK).

The PDK isn't something I can simply download and use without first agreeing to an EULA. That didn't sit well with me, especially when working in the open source ecosystem.

So I thought: **Why not build something better suited to our needs?**

And that's exactly what I did! 💪

I forked the existing extension, started stripping away the PDK dependencies, and kept the parts we actually needed for language integration.

The goal was simple: **A fully open source extension, free from PDK dependencies, built for the OpenVox community.** 🐧

## From a VSIX Attached to an Issue to a Proper Release 📦

At first, the extension was more of a development experiment than a proper release.

There was no automated release process, no marketplace integration, nothing fancy. Just a VSIX file attached to a GitHub issue.

Not exactly the most elegant distribution method, but hey, it worked! 😄

Over the past few weeks, I've gradually been putting together a proper release workflow.

My first target was [Open VSX](https://open-vsx.org/), the open marketplace used by VSCodium and other VS Code-compatible editors.

I decided to leave the Microsoft VS Code Marketplace for later because I'd heard that publishing there was considerably more complicated.

But as it turned out, it wasn't nearly as difficult as I'd expected!

Both marketplaces had their own little hurdles and quirks, but nothing too dramatic. Once everything was configured, publishing turned out to be surprisingly straightforward.

I also managed to secure the **`voxpupuli` publisher name** on both platforms, so we're all set for future releases.

With the publishing workflow automated through CI, we can now release new versions to both marketplaces automatically. ✨

Along the way, **Yury joined the effort** and has been a huge help in making the extension even better!

Now, there's just one tiny detail: Neither of us knows JavaScript or Node.js particularly well.

But together? **We still don't know JavaScript or Node.js particularly well!** 😂

## 🎉 We're Live!

And that brings us to today!

I'm happy to announce that **OpenVox VS Code Extension v0.2.1** is officially available on both marketplaces!

You can grab it here:

- [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=voxpupuli.openvox-vscode)
- [Open VSX Marketplace](https://open-vsx.org/extension/voxpupuli/openvox-vscode)

There's certainly more to improve, and we'd love to have more people joining the fun!

So, if you'd like to contribute, report a bug, suggest a feature, or simply take a look at what we're building, feel free to drop by our [GitHub repository](https://github.com/voxpupuli/openvox-vscode). Contributions are always welcome! 💚
