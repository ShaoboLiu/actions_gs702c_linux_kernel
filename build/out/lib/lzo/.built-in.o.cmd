cmd_lib/lzo/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o lib/lzo/built-in.o lib/lzo/lzo_compress.o lib/lzo/lzo_decompress.o ; scripts/mod/modpost lib/lzo/built-in.o
