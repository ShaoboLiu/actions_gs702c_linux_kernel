cmd_sound/drivers/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o sound/drivers/built-in.o sound/drivers/opl3/built-in.o sound/drivers/opl4/built-in.o sound/drivers/mpu401/built-in.o sound/drivers/vx/built-in.o sound/drivers/pcsp/built-in.o ; scripts/mod/modpost sound/drivers/built-in.o
