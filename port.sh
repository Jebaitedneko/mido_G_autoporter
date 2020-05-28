zipedit(){

    #updater script magic
    curdir=$(pwd)
    [ -e "/tmp/META-INF/com/google/android/updater-script" ] && echo "Removing old file" && rm /tmp/META-INF/com/google/android/updater-script
    unzip "$1" "META-INF/com/google/android/updater-script" -d /tmp
    unzip "$1" "boot.img" -d ./ 
    cd /tmp
    sed -i 's/\"mido\"/getprop\(\"ro.product.device\"\)/g' "META-INF/com/google/android/updater-script"
    sed -i 's/\"oxygen\"/getprop\(\"ro.product.device\"\)/g' "META-INF/com/google/android/updater-script"
    sed -i 's/cust/vendor/g' "META-INF/com/google/android/updater-script"
    zip --update "$curdir/$1" "META-INF/com/google/android/updater-script"
    cd "$curdir"
    
    #unpacking magic
    mv boot.img AIK-Linux
    cp Image.gz-dtb AIK-Linux
    cd AIK-Linux && ./cleanup.sh
    ./unpackimg.sh "boot.img"
    mv Image.gz-dtb split_img/ && cd split_img/
    rm boot.img-zImage && mv Image.gz-dtb boot.img-zImage
    
    #cmdline edits
    sed -i 's/enforcing/permissive/g' boot.img-cmdline
    sed -i 's/$/ firmware_class\.path\=\/vendor\/firmware\_mnt\/image/' boot.img-cmdline
    cd .. && ./repackimg.sh
    mv image-new.img ../$1.$( date '+%F_%H:%M:%S' ).img
    rm boot.img
    cd "$curdir"
}
zipedit $1
