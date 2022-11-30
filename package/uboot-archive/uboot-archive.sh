# SPDX-License-Identifier: MPL-2.0-no-copyleft-exception

#!/bin/sh

##################################################################################
#
# Warning: This is critical code! It is used to save the GOI configuration of
# the laser in uboot-env, any wrong modification can permanently damage the laser
#
##################################################################################

NEWLINE_ESCAPE='@'

store_file() {
    local file_source=${1}
    local uboot_variable=${2}
    local output_name=${3}

    if [ ! -f "$file_source" ]; then
        echo "File \"$file_source\" does not exist!"
        exit 1
    fi

    if [ -z $output_name ]; then
        output_name="$file_source"
    fi

    local encoded=$(cat "$file_source" | uuencode -m "$output_name" | tr '\n' $NEWLINE_ESCAPE)
    fw_setenv "$uboot_variable" "$encoded"
}

export_file() {
    local uboot_variable=${1}
    local file_dest=${2}
    local uboot_value

    uboot_value=$(fw_printenv "$uboot_variable" 2>/dev/null)
    local exit_value=$?

    if [ $exit_value -ne 0 ]; then
        echo "U-Boot variable \"$uboot_variable\" does not exist"
        exit 1
    fi

    local encoded=$(echo "$uboot_value" | sed "s/^$uboot_variable=//")
    echo "$encoded" | tr $NEWLINE_ESCAPE '\n' | uudecode -o "$file_dest"
}

store_dir() {
    local path_source=${1}
    local uboot_variable=${2}
    local output_name=${3}

    if [ -z $output_name ]; then
        output_name="$path_source"
    fi

    local temp_file="/tmp/$(date '+%s')-$uboot_variable"
    tar -c "$path_source" | gzip > "$temp_file"

    store_file "$temp_file" "$uboot_variable" "$output_name"
    rm "$temp_file"
}

export_dir() {
    local uboot_variable=${1}
    local path_dest=${2}
    local temp_file="/tmp/$(date '+%s')-$uboot_variable"

    export_file "$uboot_variable" "$temp_file"
    gunzip -c "$temp_file" | tar -xf - -C "$path_dest"
    rm "$temp_file"
}

case "$1" in
    store)
        if [ "$#" -ne 3 ] && [ "$#" -ne 4 ] ; then
            echo "Usage: $0 $1 <file> <uboot_variable> <optional_output_name>"
            exit 1
        fi

        store_file ${@#"$1"}
        ;;
    export)
        if [ "$#" -ne 3 ]; then
            echo "Usage: $0 $1 <uboot_variable> <file_dest>"
            exit 1
        fi

        export_file ${@#"$1"}
        ;;
    store-dir)
        if [ "$#" -ne 3 ] && [ "$#" -ne 4 ] ; then
            echo "Usage: $0 $1 <path> <uboot_variable> <optional_output_name>"
            exit 1
        fi

        store_dir ${@#"$1"}
        ;;
    export-dir)
        if [ "$#" -ne 3 ]; then
            echo "Usage: $0 $1 <uboot_variable> <path_dest>"
            exit 1
        fi

        export_dir ${@#"$1"}
        ;;
    *)
        echo "Usage: $0 store|export|store-dir|export-dir"
        exit 1
esac
