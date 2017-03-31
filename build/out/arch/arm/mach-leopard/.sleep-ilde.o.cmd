cmd_arch/arm/mach-leopard/sleep-ilde.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-gcc -Wp,-MD,arch/arm/mach-leopard/.sleep-ilde.o.d  -nostdinc -isystem /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/include -include /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian   -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include -D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -include asm/unified.h -msoft-float -gdwarf-2   -c -o arch/arm/mach-leopard/sleep-ilde.o /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/sleep-ilde.S

source_arch/arm/mach-leopard/sleep-ilde.o := /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/sleep-ilde.S

deps_arch/arm/mach-leopard/sleep-ilde.o := \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/linkage.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/compiler.h \
    $(wildcard include/config/sparse/rcu/pointer.h) \
    $(wildcard include/config/trace/branch/profiling.h) \
    $(wildcard include/config/profile/all/branches.h) \
    $(wildcard include/config/enable/must/check.h) \
    $(wildcard include/config/enable/warn/deprecated.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/linkage.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/init.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/hotplug.h) \
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

arch/arm/mach-leopard/sleep-ilde.o: $(deps_arch/arm/mach-leopard/sleep-ilde.o)

$(deps_arch/arm/mach-leopard/sleep-ilde.o):
