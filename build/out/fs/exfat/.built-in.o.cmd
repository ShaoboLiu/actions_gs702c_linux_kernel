cmd_fs/exfat/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/exfat/built-in.o fs/exfat/exfat_core.o fs/exfat/exfat_fs.o ; scripts/mod/modpost fs/exfat/built-in.o
