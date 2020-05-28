#### [LINUX ONLY]             [MIDO/OXYGEN] ####

#### TREBLE RECOVERIES ####
Treble compatible recoveries can be found in treble-recovery

#### VENDOR PARTITIONING ####
1. Backup all your data to pc
2. Install treble recovery
3. Flash 1G repartition zip provided here
4. Use the volume buttons and select the following:
	1GB (1024MB) Vendor Partition
	FROM THE END OF DATA
5. Wipe everything except internal storage
6. Reboot recovery

#### AUTO PORTER INSTRUCTIONS ####
1. Clone this repo
2. Download a treble mido rom of your choice and place it inside the repo folder root
3. `sudo ./port.sh rom.zip`
4. You'll have a modified zip and a generated boot.img in the repo root
5. Wipe all partitions except internal storage, 
6. Reboot recovery (important)
7. Install zip and then install new generated boot.img

#### VENDOR PATCHES ####
Patches to be applied after flashing mido treble roms are in treble-fixes
