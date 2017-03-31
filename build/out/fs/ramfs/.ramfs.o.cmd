cmd_fs/ramfs/ramfs.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/ramfs/ramfs.o fs/ramfs/inode.o fs/ramfs/file-mmu.o ; scripts/mod/modpost fs/ramfs/ramfs.o
