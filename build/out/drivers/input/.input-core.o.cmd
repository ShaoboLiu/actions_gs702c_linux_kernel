cmd_drivers/input/input-core.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/input/input-core.o drivers/input/input.o drivers/input/input-compat.o drivers/input/input-mt.o drivers/input/ff-core.o ; scripts/mod/modpost drivers/input/input-core.o
