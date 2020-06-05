#!/bin/bash
apt install zip unzip
mkdir -p boot
unzip $1 $updater boot.img -d .
./unpackbootimg -i boot.img -o boot && boot=boot/boot.img
cp Image.gz-dtb $boot-zImage
sed -i 's/enforcing/permissive/g' $boot-cmdline
sed -i 's/$/ androidboot\.selinux\=\permissive/' $boot-cmdline
sed -i 's/$/ firmware_class\.path\=\/vendor\/firmware\_mnt\/image/' $boot-cmdline
cat $boot-cmdline | sed 's/ /\n/g' | sort -u | tr '\n' ' ' > boot/bcl && rm $boot-cmdline && mv boot/bcl $boot-cmdline
./mkbootimg --kernel $boot-zImage --ramdisk $boot-ramdisk.gz --cmdline "$(cat $boot-cmdline)" --base $(cat $boot-base) --pagesize $(cat $boot-pagesize) -o boot_G.img
zip -ur $1 boot_G.img && rm boot.img && rm boot_G.img
mv $1 ${1}_PORTED.zip && rm -rf boot
