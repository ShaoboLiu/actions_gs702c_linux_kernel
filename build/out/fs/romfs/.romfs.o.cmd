cmd_fs/romfs/romfs.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/romfs/romfs.o fs/romfs/storage.o fs/romfs/super.o ; scripts/mod/modpost fs/romfs/romfs.o
