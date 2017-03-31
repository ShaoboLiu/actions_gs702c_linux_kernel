cmd_fs/cramfs/cramfs.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/cramfs/cramfs.o fs/cramfs/inode.o fs/cramfs/uncompress.o ; scripts/mod/modpost fs/cramfs/cramfs.o
