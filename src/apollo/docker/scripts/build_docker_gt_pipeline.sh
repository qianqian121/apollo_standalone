#! /usr/bin/env bash

DOCKERFILE="build/dev.x86_64_opencv_contrib.dockerfile"
IMAGE_OUT="apollo/standalone:dev-x86_64-18.04-cuda11.1-v0.0.1"
context="."
echo "${context}"
set -x
docker build --network=host -t "${IMAGE_OUT}" \
        -f "${DOCKERFILE}" \
        "${context}"
set +x
