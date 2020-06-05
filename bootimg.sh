#!/bin/bash
apt install zip unzip
curdir=$(pwd)
unzip "$1" "boot.img" -d ./
mv boot.img AIK-Linux
cp Image.gz-dtb AIK-Linux
cd AIK-Linux && ./cleanup.sh
./unpackimg.sh "boot.img"
mv Image.gz-dtb split_img/ && cd split_img/
rm boot.img-zImage && mv Image.gz-dtb boot.img-zImage
sed -i 's/enforcing/permissive/g' boot.img-cmdline
sed -i 's/$/ androidboot\.selinux\=\permissive/' boot.img-cmdline
sed -i 's/$/ firmware_class\.path\=\/vendor\/firmware\_mnt\/image/' boot.img-cmdline
cat boot.img-cmdline | sed 's/ /\n/g' | sort -u | tr '\n' ' ' > bcl && rm boot.img-cmdline && mv bcl boot.img-cmdline
cd .. && ./repackimg.sh
mv image-new.img ../boot_G.img && rm boot.img
cd "$curdir"
zip -ur "$1" boot_G.img && rm boot_G.img
mv "$1" "${1}_PORTED.zip"
echo "\n\nPORTING FINISHED. FLASH '${1}_PORTED.zip' FOLLOWED BY PATCHES IN 'treble-fixes'\n\n"
