cmd_drivers/mfd/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/mfd/built-in.o drivers/mfd/mfd-core.o ; scripts/mod/modpost drivers/mfd/built-in.o
