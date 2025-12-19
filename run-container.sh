#!/usr/bin/env bash


ANDROID_VERSION=${1}
DEVICE=${2}

if [[ -z "${ANDROID_VERSION}" ]]
then
  echo "[-] Please specify android version"

  exit 1
fi

if [[ -z "${DEVICE}" ]]
then
  echo "[*] Device not specified"
  echo "    Using default device: pixel"

  DEVICE="pixel"
fi

docker run -d \
  -p 6080:6080 \
  -p 5555:5555 \
  -p 4723:4723 \
  -e DEVICE="${DEVICE}" \
  --device /dev/kvm \
  --name DeviceBox \
  sergeygrishuk/devicebox:"${ANDROID_VERSION}"
