cmd_crypto/crypto_blkcipher.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o crypto/crypto_blkcipher.o crypto/ablkcipher.o crypto/blkcipher.o ; scripts/mod/modpost crypto/crypto_blkcipher.o
