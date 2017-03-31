cmd_crypto/crypto_hash.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o crypto/crypto_hash.o crypto/ahash.o crypto/shash.o ; scripts/mod/modpost crypto/crypto_hash.o
