cmd_fs/fuse/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/fuse/built-in.o fs/fuse/fuse.o ; scripts/mod/modpost fs/fuse/built-in.o
