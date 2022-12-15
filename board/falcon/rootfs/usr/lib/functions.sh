# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

#!/bin/sh

export_goi() {
    (
        # Check if command fails
        set -e && set -o pipefail

        # Cleanup
        rm -rf /tmp/goi_config && mkdir /tmp/goi_config
        rm -rf /tmp/goi_config_corr && mkdir /tmp/goi_config_corr

        # Export GOI config from uboot-env
        uboot-archive export-dir goi_config /tmp/goi_config
        uboot-archive export-dir goi_config_corr /tmp/goi_config_corr
    )

    return $?
}

store_goi() {
    printf "Store GOI config to U-Boot: "

    (
        # Check if command fails
        set -e && set -o pipefail

        # Store goi_config
        cd /tmp/goi_config
        uboot-archive store-dir etc goi_config goi_config

        # Store goi_config_corr
        cd /tmp/goi_config_corr
        uboot-archive store-dir . goi_config_corr goi_config_corr
    )

    status=$?
    if [ "$status" -eq 0 ]; then
        echo "OK"
    else
        echo "FAIL"
    fi
    return "$status"
}

ascii_to_hex() {
    echo -ne "$1" | xxd -p | sed 's/../0x& /g' | xargs
}

get_setting() {
    fw_printenv $1 2>&- | cut -f2 -d=
}

get_setting_def() {
    local result=$(get_setting $1)

    if [ -z $result ]; then
        echo "$2"
    else
        echo "$result"
    fi
}

get_setting_boolint() {
    local result=$(get_setting_def $1 0)

    if [ "$result" -ne 1 ]; then
        echo 0
    else
        echo "$result"
    fi

}

call_onu() {
    local output=$(/opt/lantiq/bin/onu $*)
    local error_code=${output%% *}

    if [ "$error_code" != "errorcode=0" ]; then
        echo "call_onu $* failed: $output"
    fi
}

