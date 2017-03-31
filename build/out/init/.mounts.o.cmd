cmd_init/mounts.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o init/mounts.o init/do_mounts.o init/do_mounts_rd.o init/do_mounts_initrd.o ; scripts/mod/modpost init/mounts.o
