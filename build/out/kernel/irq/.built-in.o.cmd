cmd_kernel/irq/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o kernel/irq/built-in.o kernel/irq/irqdesc.o kernel/irq/handle.o kernel/irq/manage.o kernel/irq/spurious.o kernel/irq/resend.o kernel/irq/chip.o kernel/irq/dummychip.o kernel/irq/devres.o kernel/irq/autoprobe.o kernel/irq/irqdomain.o kernel/irq/proc.o kernel/irq/pm.o ; scripts/mod/modpost kernel/irq/built-in.o
