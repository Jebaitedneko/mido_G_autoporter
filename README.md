#### [LINUX / TMUX / COLAB] [MIDO/OXYGEN] ####

#### COLAB INSTANCE ####

<a href="https://colab.research.google.com/github/Jebaitedneko/mido_G_autoporter/blob/master/porter.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Port In Colab"/></a>

#### TREBLE RECOVERIES ####
Treble compatible recoveries can be found in tools/recoveries

#### VENDOR PARTITIONING ####
1. Backup all your data to pc
2. Install treble recovery
3. Flash 1G repartition zip provided here
4. Use the volume buttons and select the following: 1GB (1024MB) Vendor Partition FROM THE END OF DATA *DO NOT SELECT SYSTEM*
5. Wipe everything except internal storage
6. Format vendor (if it shows failed to mount)
7. Reboot recovery

NOTE: For those who get an Error 2 use the rewritten repartition zip

#### AUTO PORTER INSTRUCTIONS ####
1. Clone this repo
2. Download a treble mido rom of your choice and place it inside the repo folder root
3. `sudo ./port.sh rom.zip` for linux and `./port-arm.sh rom.zip` for tmux
4. You'll have a modified zip in the repo root
5. Wipe all partitions except internal storage 
6. Reboot recovery (important)
7. Install zip

#### IMPORTANT ####
Termux users must first run `pkg install root-repo` and then `apt install git` to install git

`git clone --depth=1 https://github.com/Jebaitedneko/mido_G_autoporter` to clone repo

Repo will be saved in /data/data/com.termux/files/home/mido_G_autoporter

Use a root browser to travel to that directory, place the mido zip you want to port inside the repo folder and run arm script

Vendor patches must be installed only after the first boot is completed

#### VENDOR PATCHES ####
Patches to be applied after flashing mido treble roms are in tools
