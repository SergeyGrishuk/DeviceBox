#!/usr/bin/env bash

local_ip_address="$(hostname -I | awk '{print $1}')"

echo "[I] local_ip_address: ${local_ip_address}"

/usr/bin/socat tcp-listen:5554,bind="${local_ip_address}",fork tcp:127.0.0.1:5554 & \
/usr/bin/socat tcp-listen:5555,bind="${local_ip_address}",fork tcp:127.0.0.1:5555
