cmd_net/bluetooth/bnep/bnep.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/bluetooth/bnep/bnep.o net/bluetooth/bnep/core.o net/bluetooth/bnep/sock.o net/bluetooth/bnep/netdev.o ; scripts/mod/modpost net/bluetooth/bnep/bnep.o
