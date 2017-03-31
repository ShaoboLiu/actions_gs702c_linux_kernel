cmd_net/mac80211/built-in.o :=  /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o net/mac80211/built-in.o net/mac80211/mac80211.o ; scripts/mod/modpost net/mac80211/built-in.o
