#! /usr/bin/env bash

xhost +local:

docker run --gpus all --privileged -it -e NVIDIA_DRIVER_CAPABILITIES=video,compute,graphics,utility \
    --env="DISPLAY" -env="QT_X11_NO_MITSHM=1" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw"  -v /home/dev:/mnt \
    apollo/standalone:dev-x86_64-18.04-cuda10.0-v0.0 bash
