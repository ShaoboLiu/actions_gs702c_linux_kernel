cmd_net/key/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/key/built-in.o net/key/af_key.o ; scripts/mod/modpost net/key/built-in.o
