#!/bin/bash
source "./Scripts/Linux/output_initialization.sh"

initialize_json_file

benchmark_number="1.1.1.8"
description="Ensure usb-storage kernel module is not available"

l_output=""
l_output2=""
l_output3=""
l_dl=""

l_mname="usb-storage" 
l_mtype="drivers" 
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"

module_loadable_chk() {
    l_loadable="$(modprobe -n -v "$l_mname")" 
    if [ "$(wc -l <<< "$l_loadable")" -gt "1" ]; then
        l_loadable="$(grep -P -- "^\h*install|\b$l_mname\b" <<< "$l_loadable")"
    fi

    if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
        l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
    fi
}

module_loaded_chk() {
    if ! lsmod | grep -q "$l_mname"; then
        l_output="$l_output\n - module: \"$l_mname\" is not loaded"
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
    fi
}

module_deny_chk() {
    l_dl="y"
    if modprobe --showconfig | grep -Pq -- "^\h*blacklist\h+$l_mpname\b"; then
        l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
    else
        l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
    fi
}

module_loadable_chk
module_loaded_chk
module_deny_chk

if [ -z "$l_output2" ]; then
    audit_result="PASS"
else
    audit_result="FAILED"
fi

if [ "$audit_result" = "PASS" ]; then
    status="Complied"  
else
    status="Not Complied"
fi

benchmark=$(cat ./JSON-Reports/output.json | grep $benchmark_number | wc -w)

if [ $benchmark -eq "0" ];
then
    write_to_json
fi







