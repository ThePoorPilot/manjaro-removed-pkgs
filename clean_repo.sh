#!/bin/bash

mkdir ./cleaning
cd ./cleaning

echo "Printing list of all pkgs uploaded to GitHub"
curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/ThePoorPilot/manjaro-removed-pkgs/releases 2>/dev/null | grep '"name":' | sed -n -e 's/        "name": "//p' | sed -n -e 's/",//p' | sed 's/manjaro-removed-pkgs.*//g' | sed '/^[[:space:]]*$/d' > uploaded_pkgs.txt

echo "Downloading manjaro-removed-pkgs repo database"
wget -q https://github.com/ThePoorPilot/manjaro-removed-pkgs/releases/download/x86_64/manjaro-removed-pkgs.db
echo "extracting manjaro-removed-pkgs database"
mkdir ./manjaro-removed-pkgs
{
tar -zxf ./manjaro-removed-pkgs.db -C ./manjaro-removed-pkgs
} &> /dev/null
awk '/%FILENAME%/{getline; print}' ./manjaro-removed-pkgs/*/desc > ./database_pkgs.txt

diff --new-line-format="" --unchanged-line-format=""  ./uploaded_pkgs.txt ./database_pkgs.txt  > ../files_to_delete.txt
echo 'Old files that need to be deleted printed at files_to_delete.txt'
