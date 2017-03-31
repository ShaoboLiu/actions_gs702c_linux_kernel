cmd_fs/ramfs/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/ramfs/built-in.o fs/ramfs/ramfs.o ; scripts/mod/modpost fs/ramfs/built-in.o
