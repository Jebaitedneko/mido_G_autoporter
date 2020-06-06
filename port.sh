#!/bin/bash
apt install zip unzip
updater=META-INF/com/google/android/updater-script
mkdir -p boot
[ `unzip -Z1 $1 | grep compatibility.zip` ] && zip -d $1 compatibility.zip
unzip $1 $updater boot.img -d .
sed -i 's/\"mido\"/getprop\(\"ro.product.device\"\)/g' $updater
sed -i 's/\"oxygen\"/getprop\(\"ro.product.device\"\)/g' $updater
sed -i 's/cust/vendor/g' $updater
sed -i 's/boot\.img/boot\_G\.img/g' $updater
zip --update $1 $updater
./bin/unpackbootimg -i boot.img -o boot && boot=boot/boot.img
cp bin/Image.gz-dtb $boot-zImage
sed -i 's/enforcing/permissive/g' $boot-cmdline
sed -i 's/$/ androidboot\.selinux\=\permissive/' $boot-cmdline
sed -i 's/$/ firmware_class\.path\=\/vendor\/firmware\_mnt\/image/' $boot-cmdline
cat $boot-cmdline | sed 's/ /\n/g' | sort -u | tr '\n' ' ' > boot/bcl && rm $boot-cmdline && mv boot/bcl $boot-cmdline
./bin/mkbootimg --kernel $boot-zImage --ramdisk $boot-ramdisk.gz --cmdline "$(cat $boot-cmdline)" --base $(cat $boot-base) --pagesize $(cat $boot-pagesize) -o boot_G.img
zip -ur $1 boot_G.img && rm boot.img && rm boot_G.img
mv $1 ${1}_PORTED.zip && rm -rf META-INF && rm -rf boot
