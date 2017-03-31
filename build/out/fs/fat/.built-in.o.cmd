cmd_fs/fat/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/fat/built-in.o fs/fat/fat.o fs/fat/vfat.o fs/fat/msdos.o ; scripts/mod/modpost fs/fat/built-in.o
