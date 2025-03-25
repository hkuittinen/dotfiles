#!/usr/bin/env bash
declare status 

while true; do
    if pgrep -x "wf-recorder" &>/dev/null; then
        status="REC"
    else
        status=""
    fi

    printf -- '%s\n' "status|string|${status}"
    printf -- '%s\n' ""

    sleep 2
done

unset -v status
