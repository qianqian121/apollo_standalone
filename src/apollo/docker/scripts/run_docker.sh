#! /usr/bin/env bash

DOCKER_IMAGE=$1
xhost +local:

set -x
export UID=$(id -u)
export GID=$(id -g)
docker run --gpus all --privileged -it -e NVIDIA_DRIVER_CAPABILITIES=video,compute,graphics,utility \
    --user $UID:$GID \
    --workdir="/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --env="DISPLAY" -env="QT_X11_NO_MITSHM=1" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --net=host --ipc=host --shm-size="2G" \
    -v /home/$(whoami):/mnt \
    ${DOCKER_IMAGE} bash
set +x
