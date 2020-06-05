#!/bin/bash
zipedit(){
    #updater script magic
    curdir=$(pwd)
    updater=META-INF/com/google/android/updater-script
    [ -e "/tmp/$updater" ] && rm /tmp/$updater
    unzip "$1" "$updater" -d /tmp
    unzip "$1" "boot.img" -d ./
    [ `unzip -Z1 $1 | grep compatibility.zip` ] && zip -d $1 "compatibility.zip" 
    cd /tmp
    sed -i 's/\"mido\"/getprop\(\"ro.product.device\"\)/g' "$updater"
    sed -i 's/\"oxygen\"/getprop\(\"ro.product.device\"\)/g' "$updater"
    sed -i 's/cust/vendor/g' "$updater"
    sed -i 's/boot\.img/boot\_G\.img/g' "$updater"
    zip --update "$curdir/$1" "$updater"
    cd "$curdir"
    #unpacking magic
    mv boot.img AIK-Linux
    cp Image.gz-dtb AIK-Linux
    cd AIK-Linux && ./cleanup.sh
    ./unpackimg.sh "boot.img"
    mv Image.gz-dtb split_img/ && cd split_img/
    rm boot.img-zImage && mv Image.gz-dtb boot.img-zImage
    #cmdline magic
    sed -i 's/enforcing/permissive/g' boot.img-cmdline
    sed -i 's/$/ androidboot\.selinux\=\permissive/' boot.img-cmdline
    sed -i 's/$/ firmware_class\.path\=\/vendor\/firmware\_mnt\/image/' boot.img-cmdline
    cat boot.img-cmdline | sed 's/ /\n/g' | sort -u | tr '\n' ' ' > bcl && rm boot.img-cmdline && mv bcl boot.img-cmdline
    #repacking magic
    cd .. && ./repackimg.sh
    mv image-new.img ../boot_G.img && rm boot.img
    cd "$curdir"
    zip -ur "$1" boot_G.img && rm boot_G.img
    mv "$1" "${1}_PORTED.zip"
    echo "\n\nPORTING FINISHED. FLASH '${1}_PORTED.zip' FOLLOWED BY PATCHES IN 'treble-fixes'\n\n"
}
apt install zip unzip
zipedit $1
