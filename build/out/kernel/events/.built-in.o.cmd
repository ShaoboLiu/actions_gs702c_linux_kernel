cmd_kernel/events/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o kernel/events/built-in.o kernel/events/core.o kernel/events/ring_buffer.o kernel/events/callchain.o kernel/events/hw_breakpoint.o ; scripts/mod/modpost kernel/events/built-in.o
