cmd_fs/ext2/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/ext2/built-in.o fs/ext2/ext2.o ; scripts/mod/modpost fs/ext2/built-in.o
