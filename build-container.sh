#!/usr/bin/env bash



ANDROID_VERSION=${1}
ANDROID_API_LEVEL=${2}


if [[ -z ${ANDROID_VERSION} ]]
then
    echo "[-] Please specify Android version"

    exit 1
fi

if [[ -z "${ANDROID_API_LEVEL}" ]]
then
    echo "[-] Please specify Android API level"

    exit 1
fi

docker build . \
    --build-arg ANDROID_VERSION="${ANDROID_VERSION}" \
    --build-arg ANDROID_API_LEVEL="${ANDROID_API_LEVEL}" \
    -f Dockerfiles/Dockerfile \
    -t devicebox:"${ANDROID_VERSION}"
