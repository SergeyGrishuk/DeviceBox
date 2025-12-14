#!/usr/bin/env bash

# Create a new test device
echo "no" | avdmanager create avd \
    --name test_device \
    --package "system-images;android-34;google_apis;x86_64" \
    --device "pixel"


# Run the test device
emulator -avd test_device -no-audio -no-boot-anim -gpu swiftshader_indirect
