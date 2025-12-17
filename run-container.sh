#!/usr/bin/env bash


docker run -d \
  -p 6080:6080 \
  -p 5555:5555 \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:14
