cmd_fs/proc/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o fs/proc/built-in.o fs/proc/proc.o ; scripts/mod/modpost fs/proc/built-in.o
