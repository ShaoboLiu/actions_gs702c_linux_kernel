cmd_crypto/crypto.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o crypto/crypto.o crypto/api.o crypto/cipher.o crypto/compress.o ; scripts/mod/modpost crypto/crypto.o
