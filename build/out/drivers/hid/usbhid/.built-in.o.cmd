cmd_drivers/hid/usbhid/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/hid/usbhid/built-in.o drivers/hid/usbhid/usbhid.o ; scripts/mod/modpost drivers/hid/usbhid/built-in.o
