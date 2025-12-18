#!/usr/bin/env bash


set -e


if [[ -z "${DEVICE}" ]]
then
    echo "[-] Error: Device not specified"

    exit 1
fi


# Create a new test device
echo "no" | avdmanager create avd \
    --name devicebox_device \
    --package "system-images;android-${ANDROID_API_LEVEL};google_apis;x86_64" \
    --device "${DEVICE}"


# Run the test device
emulator -avd devicebox_device -no-audio -no-boot-anim -gpu swiftshader_indirect -no-metrics
