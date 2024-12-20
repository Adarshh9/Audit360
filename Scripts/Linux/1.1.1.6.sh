#!/bin/bash
source "./Scripts/Linux/output_initialization.sh"

initialize_json_file

benchmark_number="1.1.1.6"
description="Ensure squashfs kernel module is not available"

#!/usr/bin/env bash
{
l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
l_mname="squashfs" # set module name
l_mtype="fs" # set module type
l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf
/etc/modprobe.d/*.conf"
l_mpath="/lib/modules/**/kernel/$l_mtype"
l_mpname="$(tr '-' '_' <<< "$l_mname")"
l_mndir="$(tr '-' '/' <<< "$l_mname")"
module_loadable_chk()
{
# Check if the module is currently loadable
l_loadable="$(modprobe -n -v "$l_mname")"
[ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P --
"(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
else
l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
fi
}
module_loaded_chk()
{
# Check if the module is currently loaded
if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
l_output="$l_output\n - module: \"$l_mname\" is not loaded"
else
l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
fi
}
module_deny_chk()
{
# Check if the module is deny listed
l_dl="y"
if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls --
"^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
else
l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
fi
}
# Check if the module exists on the system
for l_mdir in $l_mpath; do
if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
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

if [ -z "$l_output2" ]; then
    audit_result="PASS"

else
audit_result="FAILED"
[ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
fi

if [ "$audit_result" = "PASS" ]; then
    status="Complied"
else
    status="Not Complied"
fi
}

benchmark=$(cat ./JSON-Reports/output.json | grep $benchmark_number | wc -w)

if [ $benchmark -eq "0" ];
then
    write_to_json
fi
