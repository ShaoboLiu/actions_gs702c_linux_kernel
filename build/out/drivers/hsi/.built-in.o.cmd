cmd_drivers/hsi/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/hsi/built-in.o drivers/hsi/clients/built-in.o ; scripts/mod/modpost drivers/hsi/built-in.o
