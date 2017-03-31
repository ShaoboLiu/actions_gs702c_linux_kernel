cmd_net/rfkill/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/rfkill/built-in.o net/rfkill/rfkill.o ; scripts/mod/modpost net/rfkill/built-in.o
