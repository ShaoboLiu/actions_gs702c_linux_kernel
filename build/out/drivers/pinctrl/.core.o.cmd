cmd_drivers/pinctrl/core.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-gcc -Wp,-MD,drivers/pinctrl/.core.o.d  -nostdinc -isystem /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include -Iarch/arm/include/generated -Iinclude  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/include -include /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kconfig.h  -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/drivers/pinctrl -Idrivers/pinctrl -D__KERNEL__ -mlittle-endian   -I/home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -fno-delete-null-pointer-checks -O2 -marm -fno-dwarf2-cfi-asm -mabi=aapcs-linux -mno-thumb-interwork -funwind-tables -D__LINUX_ARM_ARCH__=7 -march=armv7-a -msoft-float -Uarm -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -g -fno-inline-functions-called-once -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(core)"  -D"KBUILD_MODNAME=KBUILD_STR(core)" -c -o drivers/pinctrl/core.o /home/developer/action_compiling_21/leopard/kernel/linux-3.4/drivers/pinctrl/core.c

source_drivers/pinctrl/core.o := /home/developer/action_compiling_21/leopard/kernel/linux-3.4/drivers/pinctrl/core.c

deps_drivers/pinctrl/core.o := \
    $(wildcard include/config/debug/fs.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kernel.h \
    $(wildcard include/config/lbdaf.h) \
    $(wildcard include/config/preempt/voluntary.h) \
    $(wildcard include/config/debug/atomic/sleep.h) \
    $(wildcard include/config/prove/locking.h) \
    $(wildcard include/config/ring/buffer.h) \
    $(wildcard include/config/tracing.h) \
    $(wildcard include/config/numa.h) \
    $(wildcard include/config/compaction.h) \
    $(wildcard include/config/ftrace/mcount/record.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/sysinfo.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/types.h \
    $(wildcard include/config/uid16.h) \
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
  /opt/arm-2011.09/bin/../lib/gcc/arm-none-linux-gnueabi/4.6.1/include/stdarg.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/linkage.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/linkage.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/bitops.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/bitops.h \
    $(wildcard include/config/smp.h) \
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
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/log2.h \
    $(wildcard include/config/arch/has/ilog2/u32.h) \
    $(wildcard include/config/arch/has/ilog2/u64.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/printk.h \
    $(wildcard include/config/printk.h) \
    $(wildcard include/config/dynamic/debug.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/init.h \
    $(wildcard include/config/modules.h) \
    $(wildcard include/config/hotplug.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/dynamic_debug.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/div64.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/compiler.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/bug.h \
    $(wildcard include/config/bug.h) \
    $(wildcard include/config/thumb2/kernel.h) \
    $(wildcard include/config/debug/bugverbose.h) \
    $(wildcard include/config/arm/lpae.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/bug.h \
    $(wildcard include/config/generic/bug.h) \
    $(wildcard include/config/generic/bug/relative/pointers.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/export.h \
    $(wildcard include/config/symbol/prefix.h) \
    $(wildcard include/config/modversions.h) \
    $(wildcard include/config/unused/symbols.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/device.h \
    $(wildcard include/config/debug/devres.h) \
    $(wildcard include/config/cma.h) \
    $(wildcard include/config/devtmpfs.h) \
    $(wildcard include/config/sysfs/deprecated.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/ioport.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kobject.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/list.h \
    $(wildcard include/config/debug/list.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/poison.h \
    $(wildcard include/config/illegal/pointer/value.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/const.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/sysfs.h \
    $(wildcard include/config/debug/lock/alloc.h) \
    $(wildcard include/config/sysfs.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/errno.h \
  arch/arm/include/generated/asm/errno.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/errno.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/errno-base.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/lockdep.h \
    $(wildcard include/config/lockdep.h) \
    $(wildcard include/config/lock/stat.h) \
    $(wildcard include/config/prove/rcu.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kobject_ns.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/atomic.h \
    $(wildcard include/config/arch/has/atomic/or.h) \
    $(wildcard include/config/generic/atomic64.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/atomic.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/barrier.h \
    $(wildcard include/config/cpu/32v6k.h) \
    $(wildcard include/config/cpu/xsc3.h) \
    $(wildcard include/config/cpu/fa526.h) \
    $(wildcard include/config/arch/has/barriers.h) \
    $(wildcard include/config/arm/dma/mem/bufferable.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/outercache.h \
    $(wildcard include/config/outer/cache/sync.h) \
    $(wildcard include/config/outer/cache.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/cmpxchg.h \
    $(wildcard include/config/cpu/sa1100.h) \
    $(wildcard include/config/cpu/sa110.h) \
    $(wildcard include/config/cpu/v6.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/cmpxchg-local.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/atomic-long.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/spinlock.h \
    $(wildcard include/config/debug/spinlock.h) \
    $(wildcard include/config/generic/lockbreak.h) \
    $(wildcard include/config/preempt.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/preempt.h \
    $(wildcard include/config/debug/preempt.h) \
    $(wildcard include/config/preempt/count.h) \
    $(wildcard include/config/preempt/notifiers.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/thread_info.h \
    $(wildcard include/config/compat.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/thread_info.h \
    $(wildcard include/config/arm/thumbee.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/fpstate.h \
    $(wildcard include/config/vfpv3.h) \
    $(wildcard include/config/iwmmxt.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/domain.h \
    $(wildcard include/config/io/36.h) \
    $(wildcard include/config/cpu/use/domains.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/stringify.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/bottom_half.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/spinlock_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/spinlock_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rwlock_types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/spinlock.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/processor.h \
    $(wildcard include/config/have/hw/breakpoint.h) \
    $(wildcard include/config/mmu.h) \
    $(wildcard include/config/arm/errata/754327.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/hw_breakpoint.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rwlock.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/spinlock_api_smp.h \
    $(wildcard include/config/inline/spin/lock.h) \
    $(wildcard include/config/inline/spin/lock/bh.h) \
    $(wildcard include/config/inline/spin/lock/irq.h) \
    $(wildcard include/config/inline/spin/lock/irqsave.h) \
    $(wildcard include/config/inline/spin/trylock.h) \
    $(wildcard include/config/inline/spin/trylock/bh.h) \
    $(wildcard include/config/uninline/spin/unlock.h) \
    $(wildcard include/config/inline/spin/unlock/bh.h) \
    $(wildcard include/config/inline/spin/unlock/irq.h) \
    $(wildcard include/config/inline/spin/unlock/irqrestore.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rwlock_api_smp.h \
    $(wildcard include/config/inline/read/lock.h) \
    $(wildcard include/config/inline/write/lock.h) \
    $(wildcard include/config/inline/read/lock/bh.h) \
    $(wildcard include/config/inline/write/lock/bh.h) \
    $(wildcard include/config/inline/read/lock/irq.h) \
    $(wildcard include/config/inline/write/lock/irq.h) \
    $(wildcard include/config/inline/read/lock/irqsave.h) \
    $(wildcard include/config/inline/write/lock/irqsave.h) \
    $(wildcard include/config/inline/read/trylock.h) \
    $(wildcard include/config/inline/write/trylock.h) \
    $(wildcard include/config/inline/read/unlock.h) \
    $(wildcard include/config/inline/write/unlock.h) \
    $(wildcard include/config/inline/read/unlock/bh.h) \
    $(wildcard include/config/inline/write/unlock/bh.h) \
    $(wildcard include/config/inline/read/unlock/irq.h) \
    $(wildcard include/config/inline/write/unlock/irq.h) \
    $(wildcard include/config/inline/read/unlock/irqrestore.h) \
    $(wildcard include/config/inline/write/unlock/irqrestore.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kref.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/bug.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/wait.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/current.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/klist.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/mutex.h \
    $(wildcard include/config/debug/mutexes.h) \
    $(wildcard include/config/have/arch/mutex/cpu/relax.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/mutex-debug.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pm.h \
    $(wildcard include/config/pm.h) \
    $(wildcard include/config/pm/sleep.h) \
    $(wildcard include/config/pm/runtime.h) \
    $(wildcard include/config/pm/clk.h) \
    $(wildcard include/config/pm/generic/domains.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/workqueue.h \
    $(wildcard include/config/debug/objects/work.h) \
    $(wildcard include/config/freezer.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/timer.h \
    $(wildcard include/config/timer/stats.h) \
    $(wildcard include/config/debug/objects/timers.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/ktime.h \
    $(wildcard include/config/ktime/scalar.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/time.h \
    $(wildcard include/config/arch/uses/gettimeoffset.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/cache.h \
    $(wildcard include/config/arch/has/cache/line/size.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/cache.h \
    $(wildcard include/config/arm/l1/cache/shift.h) \
    $(wildcard include/config/aeabi.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/seqlock.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/math64.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/jiffies.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/timex.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/param.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/param.h \
    $(wildcard include/config/hz.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/timex.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/mach-leopard/include/mach/timex.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/debugobjects.h \
    $(wildcard include/config/debug/objects.h) \
    $(wildcard include/config/debug/objects/free.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/threads.h \
    $(wildcard include/config/nr/cpus.h) \
    $(wildcard include/config/base/small.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/completion.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/device.h \
    $(wildcard include/config/dmabounce.h) \
    $(wildcard include/config/iommu/api.h) \
    $(wildcard include/config/arch/omap.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pm_wakeup.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/slab.h \
    $(wildcard include/config/slab/debug.h) \
    $(wildcard include/config/kmemcheck.h) \
    $(wildcard include/config/failslab.h) \
    $(wildcard include/config/slub.h) \
    $(wildcard include/config/slob.h) \
    $(wildcard include/config/debug/slab.h) \
    $(wildcard include/config/slab.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/gfp.h \
    $(wildcard include/config/highmem.h) \
    $(wildcard include/config/zone/dma.h) \
    $(wildcard include/config/zone/dma32.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/mmzone.h \
    $(wildcard include/config/force/max/zoneorder.h) \
    $(wildcard include/config/memory/hotplug.h) \
    $(wildcard include/config/sparsemem.h) \
    $(wildcard include/config/have/memblock/node/map.h) \
    $(wildcard include/config/discontigmem.h) \
    $(wildcard include/config/flat/node/mem/map.h) \
    $(wildcard include/config/cgroup/mem/res/ctlr.h) \
    $(wildcard include/config/no/bootmem.h) \
    $(wildcard include/config/have/memory/present.h) \
    $(wildcard include/config/have/memoryless/nodes.h) \
    $(wildcard include/config/need/node/memmap/size.h) \
    $(wildcard include/config/have/memblock/node.h) \
    $(wildcard include/config/need/multiple/nodes.h) \
    $(wildcard include/config/have/arch/early/pfn/to/nid.h) \
    $(wildcard include/config/flatmem.h) \
    $(wildcard include/config/sparsemem/extreme.h) \
    $(wildcard include/config/have/arch/pfn/valid.h) \
    $(wildcard include/config/nodes/span/other/nodes.h) \
    $(wildcard include/config/holes/in/zone.h) \
    $(wildcard include/config/arch/has/holes/memorymodel.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/numa.h \
    $(wildcard include/config/nodes/shift.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/nodemask.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/bitmap.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/string.h \
    $(wildcard include/config/binary/printf.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/string.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pageblock-flags.h \
    $(wildcard include/config/hugetlb/page.h) \
    $(wildcard include/config/hugetlb/page/size/variable.h) \
  include/generated/bounds.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/page.h \
    $(wildcard include/config/cpu/copy/v3.h) \
    $(wildcard include/config/cpu/copy/v4wt.h) \
    $(wildcard include/config/cpu/copy/v4wb.h) \
    $(wildcard include/config/cpu/copy/feroceon.h) \
    $(wildcard include/config/cpu/copy/fa.h) \
    $(wildcard include/config/cpu/xscale.h) \
    $(wildcard include/config/cpu/copy/v6.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/glue.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/pgtable-2level-types.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/memory.h \
    $(wildcard include/config/need/mach/memory/h.h) \
    $(wildcard include/config/page/offset.h) \
    $(wildcard include/config/dram/size.h) \
    $(wildcard include/config/dram/base.h) \
    $(wildcard include/config/have/tcm.h) \
    $(wildcard include/config/arm/patch/phys/virt.h) \
    $(wildcard include/config/phys/offset.h) \
  arch/arm/include/generated/asm/sizes.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/sizes.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/memory_model.h \
    $(wildcard include/config/sparsemem/vmemmap.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/getorder.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/memory_hotplug.h \
    $(wildcard include/config/memory/hotremove.h) \
    $(wildcard include/config/have/arch/nodedata/extension.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/notifier.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rwsem.h \
    $(wildcard include/config/rwsem/generic/spinlock.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rwsem-spinlock.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/srcu.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rcupdate.h \
    $(wildcard include/config/rcu/torture/test.h) \
    $(wildcard include/config/tree/rcu.h) \
    $(wildcard include/config/tree/preempt/rcu.h) \
    $(wildcard include/config/rcu/trace.h) \
    $(wildcard include/config/preempt/rcu.h) \
    $(wildcard include/config/tiny/rcu.h) \
    $(wildcard include/config/tiny/preempt/rcu.h) \
    $(wildcard include/config/debug/objects/rcu/head.h) \
    $(wildcard include/config/hotplug/cpu.h) \
    $(wildcard include/config/preempt/rt.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/cpumask.h \
    $(wildcard include/config/cpumask/offstack.h) \
    $(wildcard include/config/debug/per/cpu/maps.h) \
    $(wildcard include/config/disable/obsolete/cpumask/functions.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rcutree.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/topology.h \
    $(wildcard include/config/sched/smt.h) \
    $(wildcard include/config/sched/mc.h) \
    $(wildcard include/config/sched/book.h) \
    $(wildcard include/config/use/percpu/numa/node/id.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/smp.h \
    $(wildcard include/config/use/generic/smp/helpers.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/smp.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/percpu.h \
    $(wildcard include/config/need/per/cpu/embed/first/chunk.h) \
    $(wildcard include/config/need/per/cpu/page/first/chunk.h) \
    $(wildcard include/config/have/setup/per/cpu/area.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pfn.h \
  arch/arm/include/generated/asm/percpu.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/percpu.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/percpu-defs.h \
    $(wildcard include/config/debug/force/weak/per/cpu.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/topology.h \
    $(wildcard include/config/arm/cpu/topology.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/topology.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/mmdebug.h \
    $(wildcard include/config/debug/vm.h) \
    $(wildcard include/config/debug/virtual.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/slub_def.h \
    $(wildcard include/config/slub/stats.h) \
    $(wildcard include/config/slub/debug.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kmemleak.h \
    $(wildcard include/config/debug/kmemleak.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/err.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/debugfs.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/fs.h \
    $(wildcard include/config/fs/posix/acl.h) \
    $(wildcard include/config/security.h) \
    $(wildcard include/config/quota.h) \
    $(wildcard include/config/fsnotify.h) \
    $(wildcard include/config/ima.h) \
    $(wildcard include/config/epoll.h) \
    $(wildcard include/config/debug/writecount.h) \
    $(wildcard include/config/file/locking.h) \
    $(wildcard include/config/auditsyscall.h) \
    $(wildcard include/config/block.h) \
    $(wildcard include/config/fs/xip.h) \
    $(wildcard include/config/migration.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/limits.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/ioctl.h \
  arch/arm/include/generated/asm/ioctl.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/ioctl.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/blk_types.h \
    $(wildcard include/config/blk/dev/integrity.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/kdev_t.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/dcache.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rculist.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/rculist_bl.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/list_bl.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/bit_spinlock.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/path.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/stat.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/stat.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/radix-tree.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/prio_tree.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pid.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/capability.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/semaphore.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/fiemap.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/shrinker.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/migrate_mode.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/quota.h \
    $(wildcard include/config/quota/netlink/interface.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/percpu_counter.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/dqblk_xfs.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/dqblk_v1.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/dqblk_v2.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/dqblk_qtree.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/nfs_fs_i.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/fcntl.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/arch/arm/include/asm/fcntl.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/asm-generic/fcntl.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/seq_file.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pinctrl/pinctrl.h \
    $(wildcard include/config/pinctrl.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pinctrl/pinctrl-state.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pinctrl/machine.h \
    $(wildcard include/config/pinmux.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/drivers/pinctrl/core.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/include/linux/pinctrl/pinconf.h \
    $(wildcard include/config/pinconf.h) \
    $(wildcard include/config/generic/pinconf.h) \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/drivers/pinctrl/pinmux.h \
  /home/developer/action_compiling_21/leopard/kernel/linux-3.4/drivers/pinctrl/pinconf.h \

drivers/pinctrl/core.o: $(deps_drivers/pinctrl/core.o)

$(deps_drivers/pinctrl/core.o):
