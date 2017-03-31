cmd_drivers/spi/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/spi/built-in.o drivers/spi/spi.o ; scripts/mod/modpost drivers/spi/built-in.o
