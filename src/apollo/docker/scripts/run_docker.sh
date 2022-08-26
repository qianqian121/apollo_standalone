#! /usr/bin/env bash

xhost +local:

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
    apollo/standalone:dev-x86_64-18.04-cuda10.0-v0.0 bash
