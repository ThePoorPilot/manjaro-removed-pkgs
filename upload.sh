#!/bin/bash

#dependencies: sshpass

#ssh-keyscan -H shell.sourceforge.net >> ~/.ssh/known_hosts

cd ./packages
#use env variable SSHPASS in action yaml
sshpass -e scp * thepoorpilot@shell.sourceforge.net:/home/frs/project/manjaro-removed-pkgs/os/x86_64
