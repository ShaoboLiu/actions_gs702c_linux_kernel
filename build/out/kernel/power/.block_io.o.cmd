cmd_kernel/power/block_io.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-gcc -Wp,-MD,kernel/power/.block_io.o.d  -nostdinc -isystem /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/include -include /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kconfig.h  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/kernel/power -Ikernel/power -D__KERNEL__ -mlittle-endian   -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -DDEBUG    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(block_io)"  -D"KBUILD_MODNAME=KBUILD_STR(block_io)" -c -o kernel/power/block_io.o /home/developer/action_compiling_21/leopard/kernel/linux-3.4/kernel/power/block_io.c

source_kernel/power/block_io.o := /home/developer/action_compiling_21/leopard/kernel/linux-3.4/kernel/power/block_io.c

deps_kernel/power/block_io.o := \
    $(wildcard include/config/fast/hibernate.h) \

kernel/power/block_io.o: $(deps_kernel/power/block_io.o)

$(deps_kernel/power/block_io.o):
