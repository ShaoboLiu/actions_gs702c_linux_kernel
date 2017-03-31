cmd_fs/debugfs/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/debugfs/built-in.o fs/debugfs/debugfs.o ; scripts/mod/modpost fs/debugfs/built-in.o
