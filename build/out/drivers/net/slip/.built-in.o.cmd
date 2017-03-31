cmd_drivers/net/slip/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/net/slip/built-in.o drivers/net/slip/slhc.o ; scripts/mod/modpost drivers/net/slip/built-in.o
