# manjaro-removed-pkgs
Repository that hosts all the packages on the Arch repo that are unavailable/removed on Manjaro.

Packages are currently hosted in a github release here:
https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/

Everything at the moment is in development. Hourly sync is now working, but in testing.

You can add the repo in /etc/pacman.conf by adding this entry

```
[manjaro-removed-pkgs]
Server = https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/$arch
```

At the current moment I think the trust level needs to be "Optional TrustAll"

To-do:

Packages are currently not signed. I am considering signing with a GPG key, but that would require maintiaining a manjaro-removed-packages-keyring package. 
