cmd_drivers/net/usb/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o drivers/net/usb/built-in.o drivers/net/usb/usbnet.o ; scripts/mod/modpost drivers/net/usb/built-in.o
