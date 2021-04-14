#!/bin/bash

cd ./finding

#download $repo.db from both repos
echo "Downloading $repo databases..."
wget -q -O "$repo"_arch.db "$ARCH_REPO""/$repo/os/x86_64/$repo.db"
wget -q -O "$repo"_manjaro.db "$MANJARO_REPO""/$repo/x86_64/$repo.db"

mkdir ./"$repo"_arch
mkdir ./"$repo"_manjaro

echo "Extracting $repo databases"
# /dev/null hides ridiculous output
{
tar -zxf ./"$repo"_arch.db -C ./"$repo"_arch
tar -zxf ./"$repo"_manjaro.db -C ./"$repo"_manjaro
} &> /dev/null

#get package names from each db
awk '/%NAME%/{getline; print}' ./"$repo"_arch/*/desc > ./data/"$repo"_arch_pkgs.txt
awk '/%NAME%/{getline; print}' ./"$repo"_manjaro/*/desc > ./data/"$repo"_manjaro_pkgs.txt

#find differences
diff --new-line-format="" --unchanged-line-format=""  ./data/"$repo"_arch_pkgs.txt ./data/"$repo"_manjaro_pkgs.txt > ./"$repo"_diff.txt
echo "Packages on Arch Repos but not on Manjaro printed at "$repo"_diff.txt"

echo "Generate file names"
#taken from https://stackoverflow.com/questions/30988586/creating-an-array-from-a-text-file-in-bash. Can't fully understand it, but it seems to work
{
mapfile -t myArray < "$repo"_diff.txt
while IFS= read -r line;
do ksh -c "awk '/%FILENAME%/{getline; print}' ./"$repo"_arch/$line-+([0-9])*-+([0-9])*//desc"
done < "$repo"_diff.txt
} > "$repo"_diff_dl.txt

#replace file names in dl list to match with repo
sed -i 's/:/colon/g' ./"$repo"_diff_dl.txt

diff --new-line-format="" --unchanged-line-format=""  ./"$repo"_diff_dl.txt ./manjaro_removed_pkgs.txt > dl_$repo.txt

#replace period with colon again for use in downloading
sed -i 's/colon/:/g' ./dl_$repo.txt

echo "Downloading needed packages from $repo..."
mapfile -t myArray < dl_$repo.txt
while IFS= read -r line;
do wget "$ARCH_REPO""/$repo/os/x86_64/""$line" -P ../packages;
done < dl_$repo.txt
