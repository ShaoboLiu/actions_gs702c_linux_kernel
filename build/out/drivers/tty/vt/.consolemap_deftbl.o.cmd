cmd_drivers/tty/vt/consolemap_deftbl.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-gcc -Wp,-MD,drivers/tty/vt/.consolemap_deftbl.o.d  -nostdinc -isystem /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/include -include /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kconfig.h  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/drivers/tty/vt -Idrivers/tty/vt -D__KERNEL__ -mlittle-endian   -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(consolemap_deftbl)"  -D"KBUILD_MODNAME=KBUILD_STR(consolemap_deftbl)" -c -o drivers/tty/vt/consolemap_deftbl.o drivers/tty/vt/consolemap_deftbl.c

source_drivers/tty/vt/consolemap_deftbl.o := drivers/tty/vt/consolemap_deftbl.c

deps_drivers/tty/vt/consolemap_deftbl.o := \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
    $(wildcard include/config/64bit.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/int-ll64.h \
  arch/arm/include/generated/asm/bitsperlong.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitsperlong.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/posix_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/stddef.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/compiler-gcc.h \
    $(wildcard include/config/arch/supports/optimized/inlining.h) \
    $(wildcard include/config/optimize/inlining.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/compiler-gcc4.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/posix_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/posix_types.h \

drivers/tty/vt/consolemap_deftbl.o: $(deps_drivers/tty/vt/consolemap_deftbl.o)

$(deps_drivers/tty/vt/consolemap_deftbl.o):
