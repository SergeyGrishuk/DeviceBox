#!/usr/bin/env bash


set -e


if [[ -z "${DEVICE}" ]]
then
    DEVICE="pixel"
fi


DEVICE_NAME="$(echo -n "DeviceBox_${DEVICE}" | tr ' ' '_')"


# Create a new test device
echo "no" | avdmanager create avd \
    --name "${DEVICE_NAME}" \
    --package "system-images;android-${ANDROID_API_LEVEL};google_apis;x86_64" \
    --device "${DEVICE}"


# Run the test device
emulator -avd "${DEVICE_NAME}" -no-audio -no-boot-anim -gpu swiftshader_indirect -no-metrics
