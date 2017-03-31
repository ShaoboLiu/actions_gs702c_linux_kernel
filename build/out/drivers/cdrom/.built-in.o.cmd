cmd_drivers/cdrom/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/cdrom/built-in.o drivers/cdrom/cdrom.o ; scripts/mod/modpost drivers/cdrom/built-in.o
