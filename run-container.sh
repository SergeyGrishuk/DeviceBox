#!/usr/bin/env bash


docker run -d \
  -p 6080:6080 \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:latest
