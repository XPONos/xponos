# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

#!/bin/sh

# Generate symlink for libs
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.0" "${TARGET_DIR}/usr/lib/libm.so.0"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.1" "${TARGET_DIR}/usr/lib/libm.so.1"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.0" "${TARGET_DIR}/usr/lib/libpthread.so.0"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.1" "${TARGET_DIR}/usr/lib/libpthread.so.1"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.1" "${TARGET_DIR}/usr/lib/librt.so.0"


# Generate symlink for GOI config
curr_dir=$(pwd)
mkdir -p "${TARGET_DIR}/etc/config" && cd "${TARGET_DIR}/etc/config"
ln -sf /tmp/goi_config/etc/config/goi_config goi_config
mkdir -p "${TARGET_DIR}/etc/optic"
cd "$curr_dir"
