# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

#!/bin/sh

# Generate symlink for libs
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.0" "${TARGET_DIR}/usr/lib/libm.so.0"
ln -sfr "${TARGET_DIR}/usr/lib/libc.so.1" "${TARGET_DIR}/usr/lib/libm.so.1"
