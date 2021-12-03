#! /usr/bin/env bash

DOCKERFILE="build/test_user.dockerfile"
IMAGE_OUT="test/test:v0"
context="."
echo "${context}"
set -x
docker build --network=host -t "${IMAGE_OUT}" \
        -f "${DOCKERFILE}" \
        "${context}"
set +x
