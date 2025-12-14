#!/usr/bin/env bash


docker run \
    --rm -d \
    --name DeviceBox \
    -p 6080:6080 \
    --device /dev/kvm \
    devicebox
