#!/usr/bin/env bash


ANDROID_VERSION=${1}

if [[ -z "${ANDROID_VERSION}" ]]
then
  echo "[-] Please specify android version"

  exit 1
fi

docker run -d \
  -p 6080:6080 \
  -p 5555:5555 \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:"${ANDROID_VERSION}"
