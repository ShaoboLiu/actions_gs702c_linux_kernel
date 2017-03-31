cmd_net/ethernet/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/ethernet/built-in.o net/ethernet/eth.o ; scripts/mod/modpost net/ethernet/built-in.o
