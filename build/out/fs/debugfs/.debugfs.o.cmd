cmd_fs/debugfs/debugfs.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/debugfs/debugfs.o fs/debugfs/inode.o fs/debugfs/file.o ; scripts/mod/modpost fs/debugfs/debugfs.o
