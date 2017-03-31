cmd_fs/ext4/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/ext4/built-in.o fs/ext4/ext4.o ; scripts/mod/modpost fs/ext4/built-in.o
