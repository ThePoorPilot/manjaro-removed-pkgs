# manjaro-removed-pkgs
Arch Linux Repository that hosts all the packages on the Arch Repo that are unavailable/removed on Manjaro. This is useful for Manjaro users who want a specific removed package or users trying to convert Arch Linux to Manjaro.

Manjaro had decided to selectively remove packages from the Arch Linux Repository. Some of these choices are quite reasonable, such as grub-customizer. While it is in this repo, you should never ever use it unless you want a broken system.

Manjaro also has made some removals that are a little more annoying. For example, they have removed the linux-zen kernel. I guess they just assumed an average user would not want to try using a custom kernel, but I still thinking users should be able to have the choice. If you disagree with any of the Manjaro team's removals, this repo should have what you need!

Packages are currently hosted in a github release here:
https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/

Everything at the moment is in development. Hourly sync is now working, but in testing.

You can add the repo in /etc/pacman.conf by adding this entry

```
[manjaro-removed-pkgs]
SigLevel = Optional TrustAll
Server = https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/$arch
```

To-do:

Packages are currently not signed. I am considering signing with a GPG key, but that would require a manjaro-removed-packages-keyring package. 
