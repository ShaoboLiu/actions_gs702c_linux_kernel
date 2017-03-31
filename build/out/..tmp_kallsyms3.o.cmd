cmd_.tmp_kallsyms3.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-gcc -Wp,-MD,./..tmp_kallsyms3.o.d -D__ASSEMBLY__ -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables  -D__LINUX_ARM_ARCH__=7 -march=armv7-a  -include asm/unified.h -msoft-float -gdwarf-2    -nostdinc -isystem /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/include -include /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kconfig.h -D__KERNEL__ -mlittle-endian -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include    -c -o .tmp_kallsyms3.o .tmp_kallsyms3.S

source_.tmp_kallsyms3.o := .tmp_kallsyms3.S

deps_.tmp_kallsyms3.o := \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/unified.h \
    $(wildcard include/config/arm/asm/unified.h) \
    $(wildcard include/config/thumb2/kernel.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/int-ll64.h \
  arch/arm/include/generated/asm/bitsperlong.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bitsperlong.h \
    $(wildcard include/config/64bit.h) \

.tmp_kallsyms3.o: $(deps_.tmp_kallsyms3.o)

$(deps_.tmp_kallsyms3.o):
