cmd_lib/find_next_bit.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-gcc -Wp,-MD,lib/.find_next_bit.o.d  -nostdinc -isystem /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/include -include /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kconfig.h  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/lib -Ilib -D__KERNEL__ -mlittle-endian   -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(find_next_bit)"  -D"KBUILD_MODNAME=KBUILD_STR(find_next_bit)" -c -o lib/find_next_bit.o /home/developer/action_compiling_21/leopard/kernel/linux-3.4/lib/find_next_bit.c

source_lib/find_next_bit.o := /home/developer/action_compiling_21/leopard/kernel/linux-3.4/lib/find_next_bit.c

deps_lib/find_next_bit.o := \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/bitops.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/int-ll64.h \
  arch/arm/include/generated/asm/bitsperlong.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitsperlong.h \
    $(wildcard include/config/64bit.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/bitops.h \
    $(wildcard include/config/smp.h) \
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
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/irqflags.h \
    $(wildcard include/config/trace/irqflags.h) \
    $(wildcard include/config/irqsoff/tracer.h) \
    $(wildcard include/config/preempt/tracer.h) \
    $(wildcard include/config/trace/irqflags/support.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/typecheck.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/irqflags.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/ptrace.h \
    $(wildcard include/config/cpu/endian/be8.h) \
    $(wildcard include/config/arm/thumb.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/hwcap.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/stddef.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/arch/dma/addr/t/64bit.h) \
    $(wildcard include/config/phys/addr/t/64bit.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/posix_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/posix_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/posix_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/non-atomic.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/fls64.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/sched.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/hweight.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/arch_hweight.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/const_hweight.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/lock.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/le.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/byteorder.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/byteorder/little_endian.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/swab.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/swab.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/byteorder/generic.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitops/ext2-atomic-setbit.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/export.h \
    $(wildcard include/config/symbol/prefix.h) \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/modversions.h) \
    $(wildcard include/config/unused/symbols.h) \

lib/find_next_bit.o: $(deps_lib/find_next_bit.o)

$(deps_lib/find_next_bit.o):
