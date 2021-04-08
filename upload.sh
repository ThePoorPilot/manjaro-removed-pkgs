#!/bin/bash

#dependencies: sshpass

#ssh-keyscan -H shell.sourceforge.net >> ~/.ssh/known_hosts

cd ./packages
#use env variable SSHPASS in action yaml
sshpass -e scp ./* thepoorpilot@frs.sourceforge.net:/home/frs/p/manjaro-removed-pkgs/x86_64
