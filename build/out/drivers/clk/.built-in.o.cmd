cmd_drivers/clk/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/clk/built-in.o drivers/clk/clkdev.o ; scripts/mod/modpost drivers/clk/built-in.o
