#!/bin/bash

source "./Scripts/Linux/output_initialization.sh"
initialize_json_file

benchmark="2.1.8"
description="Ensure message access server services are not in use"
is_installed=$(dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}\n' dovecot-imapd dovecot-pop3d | grep "installed" | wc -l)
is_enabled=$( systemctl is-enabled dovecot.socket dovecot.service 2>/dev/null | grep 'enabled' | wc -l)
is_active=$( systemctl is-active dovecot.socket dovecot.service 2>/dev/null | grep '^active' | wc -l)

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
