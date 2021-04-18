#!/bin/bash

rm -rf ./finding
rm -rf ./packages
mkdir ./finding
mkdir ./finding/data
mkdir ./packages

#configure so repo-add works later
cd ./packages
echo "Configuring Repo in packages folder"
wget -q https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/manjaro-removed-pkgs.db.tar.gz
wget -q https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/manjaro-removed-pkgs.db
wget -q https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/manjaro-removed-pkgs.files.tar.gz
wget -q https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/manjaro-removed-pkgs.files

cd ../
cd ./finding
#download manjaro-removed-pkgs db file
echo "Downloading manjaro-removed-pkgs repo files..."
wget -q https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/manjaro-removed-pkgs.db
echo "extracting manjaro-removed-pkgs database"
mkdir ./manjaro-removed-pkgs
{
tar -zxf ./manjaro-removed-pkgs.db -C ./manjaro-removed-pkgs
} &> /dev/null
awk '/%FILENAME%/{getline; print}' ./manjaro-removed-pkgs/*/desc > ./manjaro_removed_pkgs.txt

ARCH_REPO_STATUS="$(curl -s -I https://mirrors.rit.edu/archlinux/ | grep -c '200')"
MANJARO_REPO_STATUS="$(curl -s -I https://mirror.math.princeton.edu/pub/manjaro/ | grep -c '200')"

#check status of repos and replace if necessary
if [ "$ARCH_REPO_STATUS" == "1" ]
then
    echo "Arch Linux RIT mirror is up!"
    ARCH_REPO="https://mirrors.rit.edu/archlinux/"
else
    echo "Arch Linux RIT mirror not up, choosing another mirror"
    wget -O mirrorlist "https://archlinux.org/mirrorlist/?country=US&protocol=http&protocol=https&ip_version=4&use_mirror_status=on"
    ARCH_REPO="$(awk '/## United States/{getline; print}' ./mirrorlist | head -1 | sed -n -e 's/#Server = //p' | sed -n -e's:$repo/os/$arch::p')"
fi

if [ "$MANJARO_REPO_STATUS" == "1" ]
then
    echo "Princeton Manjaro Mirror is up!"
    MANJARO_REPO="https://mirror.math.princeton.edu/pub/manjaro/stable"
else
    echo "Princeton Manjaro Mirror is not up, choosing another mirror"
    #would like to have some way to pull from an active mirrorlist like is done for Arch
    #a better method to determine this could be in pacman-mirrors manjaro package
    MANJARO_REPO="https://manjaro.moson.eu/stable"
fi

cd ../

repo="core" ARCH_REPO="$ARCH_REPO" MANJARO_REPO="$MANJARO_REPO" ./differences.sh
repo="community" ARCH_REPO="$ARCH_REPO" MANJARO_REPO="$MANJARO_REPO" ./differences.sh
repo="extra" ARCH_REPO="$ARCH_REPO" MANJARO_REPO="$MANJARO_REPO" ./differences.sh
repo="multilib" ARCH_REPO="$ARCH_REPO" MANJARO_REPO="$MANJARO_REPO" ./differences.sh

cd ./packages
rm ./manjaro-removed-pkgs.db
rm ./manjaro-removed-pkgs.files

#fixes issue caused by colons in file name being replaced with period when uploaded
#namely, files with colons would be deleted by repo cleaning process
#rename command seems to operate differently on Debian
#don't fully understand, pulled from here https://superuser.com/questions/659876/how-to-rename-files-and-replace-characters
for f in *:*.pkg.tar.zst; do mv -v "$f" $(echo "$f" | sed 's/:/colon/g'); done

#generate updated releases notes
cd ../
sync_date="$(date)"

cat << EOF > ./release_notes
manjaro-removed-pkgs

All packages removed from Manjaro are included in the release below
Synced as of $sync_date
EOF

