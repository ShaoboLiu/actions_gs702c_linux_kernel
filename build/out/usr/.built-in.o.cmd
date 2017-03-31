cmd_usr/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o usr/built-in.o usr/initramfs_data.o ; scripts/mod/modpost usr/built-in.o
