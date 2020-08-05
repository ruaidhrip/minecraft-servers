#!/bin/bash

local_route=$(ip -o route get {{ ansible_default_ipv4.gateway }} | sed 's/^.* dev \(\S\+\) .*$/\1/')
default_route=$(ip -o route get 8.8.8.8 | sed 's/^.* dev \(\S\+\) .*$/\1/')

if [ "X$local_route" != "X$default_route" ]; then
        ip route delete default
        ip route add default via {{ ansible_default_ipv4.gateway }} dev $local_route
fi

exec "$@"
