cmd_arch/arm/boot/compressed/decompress.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-gcc -Wp,-MD,arch/arm/boot/compressed/.decompress.o.d  -nostdinc -isystem /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/include -include /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kconfig.h  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed -Iarch/arm/boot/compressed -D__KERNEL__ -mlittle-endian   -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -fpic -fno-builtin  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed -Iarch/arm/boot/compressed    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(decompress)"  -D"KBUILD_MODNAME=KBUILD_STR(decompress)" -c -o arch/arm/boot/compressed/decompress.o /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/decompress.c

source_arch/arm/boot/compressed/decompress.o := /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/decompress.c

deps_arch/arm/boot/compressed/decompress.o := \
    $(wildcard include/config/kernel/gzip.h) \
    $(wildcard include/config/kernel/lzo.h) \
    $(wildcard include/config/kernel/lzma.h) \
    $(wildcard include/config/kernel/xz.h) \
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
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/posix_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/posix_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/linkage.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/linkage.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/string.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/decompress_inflate.c \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/inftrees.c \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/zutil.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/zlib.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/zconf.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kernel.h \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/ring/buffer.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/inftrees.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/inffast.c \
    $(wildcard include/config/have/efficient/unaligned/access.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/inffast.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/inflate.c \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/infutil.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/boot/compressed/../../../../lib/zlib_inflate/inffixed.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/decompress/mm.h \

arch/arm/boot/compressed/decompress.o: $(deps_arch/arm/boot/compressed/decompress.o)

$(deps_arch/arm/boot/compressed/decompress.o):
