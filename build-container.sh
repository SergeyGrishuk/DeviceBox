#!/usr/bin/env bash



declare -A API_LEVEL_MAP=(
    ["9"]="28"
    ["10"]="29"
    ["11"]="30"
    ["12"]="31"
    ["12L"]="32"
    ["13"]="33"
    ["14"]="34"
    ["15"]="35"
)

ANDROID_VERSION=${1}


if [[ -z ${ANDROID_VERSION} ]]; then
    echo "[-] Error: Please specify Android version"
    echo "    Supported Android versions: ${!API_LEVEL_MAP[*]}"

    exit 1
fi

if [[ -n "${API_LEVEL_MAP[$ANDROID_VERSION]}" ]]
then
    ANDROID_API_LEVEL="${API_LEVEL_MAP[$ANDROID_VERSION]}"
    echo "[+] Auto-detected API Level: ${ANDROID_API_LEVEL}"
else
    echo "[-] Error: Unknown Android version '${ANDROID_VERSION}'."
    echo "    Known versions: ${!API_LEVEL_MAP[*]}"
    exit 1
fi

echo "[*] Building DeviceBox for Android ${ANDROID_VERSION} (API ${ANDROID_API_LEVEL})..."

docker build . \
    --build-arg ANDROID_VERSION="${ANDROID_VERSION}" \
    --build-arg ANDROID_API_LEVEL="${ANDROID_API_LEVEL}" \
    -f Dockerfiles/Dockerfile \
    -t devicebox:"${ANDROID_VERSION}"
