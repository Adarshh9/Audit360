#!/bin/bash

source "./Scripts/Linux/output_initialization.sh"
initialize_json_file

benchmark="2.1.5"
description="Ensure dnsmasq services are not in use"
is_installed=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' dnsmasq| grep "installed" | wc -l)
is_enabled=$(systemctl is-enabled dnsmasq.service 2>/dev/null | grep 'enabled' | wc -l)
is_active=$( systemctl is-active dnsmasq.service 2>/dev/null | grep '^active' | wc -l)

if [ "$is_installed" -gt 0 ]; then
    if [ "$is_enabled" -eq 0 ] && [ "$is_active" -eq 0 ]; then
        status="Complied"
    else
        status="Not Complied"
    fi

    benchmark_count=$(cat ./JSON-Reports/output.json | grep "$benchmark" | wc -l)

    if [ "$benchmark_count" -eq 0 ]; then
        write_to_json
    fi

elif [ "$is_installed" -eq 0 ]; then
    benchmark_count=$(cat ./JSON-Reports/output.json | grep "$benchmark" | wc -l)
    status="Not Complied"
    if [ "$benchmark_count" -eq 0 ]; then
        write_to_json
    fi
fi
