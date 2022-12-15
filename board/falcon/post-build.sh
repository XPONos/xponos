# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

#!/bin/sh

# Generate symlink for libs
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.0" "${TARGET_DIR}/usr/lib/libm.so.0"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.1" "${TARGET_DIR}/usr/lib/libm.so.1"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.0" "${TARGET_DIR}/usr/lib/libpthread.so.0"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.1" "${TARGET_DIR}/usr/lib/libpthread.so.1"

# Generate symlink for GOI config
curr_dir=$(pwd)
mkdir -p "${TARGET_DIR}/etc/config" && cd "${TARGET_DIR}/etc/config"
ln -sf /tmp/goi_config/etc/config/goi_config goi_config
mkdir -p "${TARGET_DIR}/etc/optic" && cd "${TARGET_DIR}/etc/optic"
ln -sf /tmp/goi_config/etc/optic/goi_age goi_age
ln -sf /tmp/goi_config/etc/optic/goi_table_laser_ref.csv goi_table_laser_ref.csv
ln -sf /tmp/goi_config/etc/optic/goi_table_laser_ref_base.csv goi_table_laser_ref_base.csv
ln -sf /tmp/goi_config/etc/optic/goi_table_vapd_bd.csv
ln -sf /tmp/goi_config_corr/goi_table_rssi1490_corr.csv goi_table_rssi1490_corr.csv
ln -sf /tmp/goi_config_corr/goi_table_text_corr.csv goi_table_text_corr.csv
cd "$curr_dir"
