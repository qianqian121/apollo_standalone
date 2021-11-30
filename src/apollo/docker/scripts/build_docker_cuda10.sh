#! /usr/bin/env bash

DOCKERFILE="build/dev.x86_64_cuda10.dockerfile"
IMAGE_OUT="apollo/standalone:dev-x86_64-18.04-cuda10.0-v0.0"
context="."
echo "${context}"
set -x
docker build --network=host -t "${IMAGE_OUT}" \
        -f "${DOCKERFILE}" \
        "${context}"
set +x
