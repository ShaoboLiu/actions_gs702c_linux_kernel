cmd_drivers/md/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/md/built-in.o drivers/md/dm-mod.o drivers/md/dm-crypt.o ; scripts/mod/modpost drivers/md/built-in.o
