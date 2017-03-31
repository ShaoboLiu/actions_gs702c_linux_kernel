cmd_drivers/power/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/power/built-in.o drivers/power/power_supply.o ; scripts/mod/modpost drivers/power/built-in.o
