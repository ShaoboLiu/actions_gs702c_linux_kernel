cmd_fs/ntfs/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/ntfs/built-in.o fs/ntfs/ntfs.o ; scripts/mod/modpost fs/ntfs/built-in.o
