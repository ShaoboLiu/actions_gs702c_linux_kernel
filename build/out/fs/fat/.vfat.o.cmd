cmd_fs/fat/vfat.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/fat/vfat.o fs/fat/namei_vfat.o ; scripts/mod/modpost fs/fat/vfat.o
