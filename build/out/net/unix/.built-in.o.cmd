cmd_net/unix/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/unix/built-in.o net/unix/unix.o ; scripts/mod/modpost net/unix/built-in.o
