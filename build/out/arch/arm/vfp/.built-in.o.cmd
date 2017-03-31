cmd_arch/arm/vfp/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL  --no-warn-mismatch   -r -o arch/arm/vfp/built-in.o arch/arm/vfp/vfp.o ; scripts/mod/modpost arch/arm/vfp/built-in.o
