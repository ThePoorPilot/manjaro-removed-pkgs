# manjaro-removed-pkgs
Arch Linux Repository that hosts all the packages on the Arch Repo that are unavailable/removed on Manjaro. This is useful for Manjaro users who want a specific removed package or users trying to convert Arch Linux to Manjaro.

Manjaro had decided to selectively remove packages from the Arch Linux Repository. Some of these choices are quite reasonable, such as grub-customizer. While it is in this repo, you should never ever use it unless you want a broken system.

Manjaro also has made some removals that are a little more annoying. For example, they have removed the linux-zen kernel. I guess they just assumed an average user would not want to try using a custom kernel, but I still think you should be able to have the choice. Plus, the linux-zen kernel is a very good all-round custom kernel.

If you need any package that is removed by the Manjaro team, this repo should have what you need!

I would recommend having some caution using this repo. Many of the modules, such as bbswitch, broadcom-wl, or tp_smapi, do have packages for each specific kernel version in the Manjaro repos. For this reason, I would only recommend using this repository for alternative Linux kernels, Arch Linux themes, Arch Linux development tools, or Perl/Haskell libraries that are removed for some reason.

### Adding the repo

You can add the repo in /etc/pacman.conf by adding this entry

```
[manjaro-removed-pkgs]
SigLevel = Optional TrustAll
Server = https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/$arch
```

### To-do:

Packages are currently not signed. I am considering signing with a GPG key, but that would require a manjaro-removed-packages keyring.

Instead of signing with a GPG key, I should probably at least add an SHA sum check in the scripting.

I initially tried using SourceForge for hosting, but their mirrors were extremely slow. It seems to be more designed for long-term storage

Packages are currently hosted in a github release here:
https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/

Hourly sync is now working, and the most recent sync time is listed on the release page.
