#!/bin/bash

source "./Scripts/Linux/output_initialization.sh"
initialize_json_file

benchmark="2.1.2"
description="Ensure avahi daemon services are not in use"
is_enabled=$(systemctl is-enabled avahi-daemon.socket avahi-daemon.service 2>/dev/null | grep 'enabled' | wc -l)
is_active=$(systemctl is-active avahi-daemon.socket avahi-daemon.service 2>/dev/null |grep '^active' | wc -l)


if [ is_enabled -eq 0 && is_active -eq 0];
then
    status="Complied"
else
    status="Not Complied"
fi

benchmark=$(cat ./JSON-Reports/output.json | grep $benchmark_number | wc -w)

if [ $benchmark -eq "0" ];
then
    write_to_json
fi