cmd_fs/exfat/exfat_fs.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/exfat/exfat_fs.o fs/exfat/exfat_super.o fs/exfat/exfat_nfs.o ; scripts/mod/modpost fs/exfat/exfat_fs.o
