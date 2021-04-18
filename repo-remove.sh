#!/bin/bash

#uses an array to delete packages no longer needed in repo
cd ./packages

echo "removing recently added pkgs from .db file"
mapfile -t myArray < ../repo-remove.txt
while IFS= read -r line;
do repo-remove ./manjaro-removed-pkgs.db.tar.gz "$line";
done < ../repo-remove.txt

cp ./manjaro-removed-pkgs.db.tar.gz ./manjaro-removed-pkgs.db
cp ./manjaro-removed-pkgs.files.tar.gz ./manjaro-removed-pkgs.files
