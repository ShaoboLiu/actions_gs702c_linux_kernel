cmd_net/packet/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/packet/built-in.o net/packet/af_packet.o ; scripts/mod/modpost net/packet/built-in.o
