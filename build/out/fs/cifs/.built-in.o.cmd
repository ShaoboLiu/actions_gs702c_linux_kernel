cmd_fs/cifs/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/cifs/built-in.o fs/cifs/cifs.o ; scripts/mod/modpost fs/cifs/built-in.o
