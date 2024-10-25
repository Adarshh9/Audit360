#!/bin/bash
source "./Scripts/Linux/output_initialization.sh"

initialize_json_file

benchmark_number="1.1.1.1"
description="Ensure cramfs kernel module is not available"

if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
    l_output="$l_output\n - module: \"$l_mname\" is not loaded"
else
    l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
fi

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
        l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
    fi
}

for l_mdir in $l_mpath; do
    if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A "$l_mdir/$l_mndir")" ]; then
        l_output3="$l_output3\n - \"$l_mdir\""
        [ "$l_dl" != "y" ] && module_deny_chk
        if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
        fi
    else
        l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
    fi
done

[ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"

if [ -z "$l_output2" ]; then
    audit_result="PASS"
else
    audit_result="FAILED"
    [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
fi

if [ "$audit_result" = "PASS" ]; then
    status="compiled"
else
    status="not compiled"
fi

benchmark=$(cat ./JSON-Reports/output.json | grep $benchmark_number | wc -w)

if [ $benchmark -eq "0" ];
then
    echo '{
    "BenchMark":"'"$benchmark_number"'",
    "Status":"'"$status"'",
    "Description":"'"$description"'"
    }' >> $OUTPUT_FILE
fi
