cmd_sound/core/snd-pcm.o := /opt/arm-2011.09/bin/arm-none-linux-gnueabi-ld -EL    -r -o sound/core/snd-pcm.o sound/core/pcm.o sound/core/pcm_native.o sound/core/pcm_lib.o sound/core/pcm_timer.o sound/core/pcm_misc.o sound/core/pcm_memory.o ; scripts/mod/modpost sound/core/snd-pcm.o
