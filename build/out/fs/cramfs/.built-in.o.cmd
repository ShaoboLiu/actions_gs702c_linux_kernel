cmd_fs/cramfs/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/cramfs/built-in.o fs/cramfs/cramfs.o ; scripts/mod/modpost fs/cramfs/built-in.o
