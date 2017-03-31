cmd_arch/arm/common/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o arch/arm/common/built-in.o arch/arm/common/gic.o ; scripts/mod/modpost arch/arm/common/built-in.o
