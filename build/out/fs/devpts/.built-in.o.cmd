cmd_fs/devpts/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/devpts/built-in.o fs/devpts/devpts.o ; scripts/mod/modpost fs/devpts/built-in.o
