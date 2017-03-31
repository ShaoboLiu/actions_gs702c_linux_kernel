cmd_drivers/switch/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/switch/built-in.o drivers/switch/switch_class.o ; scripts/mod/modpost drivers/switch/built-in.o
