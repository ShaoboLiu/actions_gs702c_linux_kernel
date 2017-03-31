cmd_fs/romfs/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/romfs/built-in.o fs/romfs/romfs.o ; scripts/mod/modpost fs/romfs/built-in.o
