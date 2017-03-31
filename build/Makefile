#
# Makefile for Actions SOC
#
# Copyright 2012 Actions Semi Inc.
# Author: Actions Semi, Inc.
#

PHONY := all kernel clean kernel_release kernel_menuconfig kernel_updateconfig 

PWD=$(shell pwd)
ROOT=$(PWD)/../..
include $(ROOT)/build/gs702c/config/build_config.cfg

KERNEL_SOURCE_DIR=$(PWD)/../linux-3.4
KERNEL_BUILD_DIR=$(PWD)/out
KERNEL_BUILD_REBUILT_DIR=$(PWD)/out-prebuilt
KERNEL_MODULES_DIR=$(PWD)/modules
KERNEL_RELEASE_DIR=$(KERNEL_PATH)/../linux-3.4-release

CROSS_COMPILE = ${TOOLCHAIN}/bin/arm-none-linux-gnueabi-

__modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(KERNEL_BUILD_DIR)/.tmp_versions/*.mod)))
cmd_modules_install = @mkdir -p $(1); cp $(KERNEL_BUILD_DIR)/$@ $(1); $(CROSS_COMPILE)strip --strip-unneeded $(1)/$(notdir $@)

all: kernel kernel_modules kernel_release

#
# build kernel
#
kernel:
	@echo "-- make kernel --"
	@mkdir -p $(KERNEL_BUILD_DIR)
    
	if [ ! -f ./out-prebuilt-list ]; then \
		cp -a $(KERNEL_BUILD_REBUILT_DIR)/* $(KERNEL_BUILD_DIR)/; \
    else \
        rm -rf $(KERNEL_BUILD_REBUILT_DIR); \
	fi
    
	cd $(KERNEL_SOURCE_DIR); \
	make O=$(KERNEL_BUILD_DIR) ARCH=arm $(R_KERNEL_CONFIG_FILE) && \
	make O=$(KERNEL_BUILD_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) -j4 KALLSYMS_EXTRA_PASS=1
    
	if [ -f ./out-prebuilt-list ]; then \
        mkdir -p $(KERNEL_BUILD_REBUILT_DIR); \
		rsync -a --files-from=./out-prebuilt-list $(KERNEL_BUILD_DIR) $(KERNEL_BUILD_REBUILT_DIR); \
        find $(KERNEL_BUILD_REBUILT_DIR) -name "*.o" | xargs $(CROSS_COMPILE)strip --strip-debug; \
	fi    
    

PHONY += $(__modules)

$(__modules):
	@echo Install $@
	$(call cmd_modules_install, $(KERNEL_MODULES_DIR), $@)

kernel_modules: $(__modules)
	@echo "-- make kernel_modules --"
	mkdir -p $(KERNEL_MODULES_DIR)

kernel_menuconfig: 
	@echo "-- kernel_menuconfig --"
	@mkdir -p $(KERNEL_BUILD_DIR); \
	cd $(KERNEL_SOURCE_DIR); \
	make O=$(KERNEL_BUILD_DIR) ARCH=arm $(R_KERNEL_CONFIG_FILE) && \
	make O=$(KERNEL_BUILD_DIR) ARCH=arm menuconfig

kernel_updateconfig: 
	@echo "-- kernel_updateconfig --"
	cp $(KERNEL_BUILD_DIR)/.config $(KERNEL_SOURCE_DIR)/arch/arm/configs/$(R_KERNEL_CONFIG_FILE)

kernel_release: 
	@echo "-- kernel_release --"
	cd $(PWD)/scirpt; \
	./release_kernel.sh $(KERNEL_SOURCE_DIR) $(KERNEL_BUILD_DIR) $(KERNEL_RELEASE_DIR) && \
	cp -r $(KERNEL_MODULES_DIR)  $(KERNEL_RELEASE_DIR)/

#
# build clean
#
clean:
	@echo "-- cleanout --"
	rm -rf $(KERNEL_BUILD_DIR);
	rm -rf $(KERNEL_MODULES_DIR)

.PHONY:  $(PHONY)
