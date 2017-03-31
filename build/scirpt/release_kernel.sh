#!/bin/sh
CUR_DIR=`pwd`

ORIG_KERNEL_SOURCE=$1
ORIG_KERNEL_BUILD_OUT=$2
RELEASE_KERNEL_SOURCE=$3
FILE_LIST_DIR=${CUR_DIR}

echo ORIG_KERNEL_SOURCE: ${ORIG_KERNEL_SOURCE}
echo ORIG_KERNEL_BUILD_OUT: ${ORIG_KERNEL_BUILD_OUT}
echo RELEASE_KERNEL_SOURCE: ${RELEASE_KERNEL_SOURCE}

mkdir -p ${RELEASE_KERNEL_SOURCE}

cd ${ORIG_KERNEL_SOURCE}
rsync -r . ${RELEASE_KERNEL_SOURCE}	\
	--files-from=${FILE_LIST_DIR}/kernel_source_sync_files.txt \
	--exclude-from=${FILE_LIST_DIR}/kernel_source_exclude_files.txt

cd ${ORIG_KERNEL_BUILD_OUT}
rsync -r . ${RELEASE_KERNEL_SOURCE}	\
	--files-from=${FILE_LIST_DIR}/kernel_build_out_sync_files.txt \
	--exclude-from=${FILE_LIST_DIR}/kernel_build_out_exclude_files.txt


