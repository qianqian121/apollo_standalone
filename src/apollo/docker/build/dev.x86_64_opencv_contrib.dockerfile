FROM nvidia/cudagl:11.1-devel-ubuntu18.04

ARG GEOLOC=us
ARG CUDA_LITE=11.1
ARG CUDNN_VERSION=8.0.4.30
ARG TENSORRT_VERSION=7.2.1
ARG WORKHORSE="gpu"

ENV DEBIAN_FRONTEND=noninteractive

# Set default shell to bash
RUN ln -sf /bin/bash /bin/sh

RUN M="${CUDNN_VERSION%%.*}" \
    && PATCH="-1+cuda${CUDA_LITE}" \
    && apt-get -y update \
    && apt-get install -y --no-install-recommends \
        libcudnn${M}="${CUDNN_VERSION}${PATCH}" \
    && apt-mark hold libcudnn${M} \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Delete static cuDNN libraries..." \
    && find /usr/lib/$(uname -m)-linux-gnu -name "libcudnn_*.a" -delete -print

ENV CUDNN_VERSION ${CUDNN_VERSION}

RUN PATCH="-1+cuda${CUDA_LITE}" && apt-get -y update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        python3-dev \
        libnvinfer7="${TENSORRT_VERSION}${PATCH}" \
        libnvonnxparsers7="${TENSORRT_VERSION}${PATCH}" \
        libnvparsers7="${TENSORRT_VERSION}${PATCH}" \
        libnvinfer-plugin7="${TENSORRT_VERSION}${PATCH}" \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -f /etc/apt/sources.list.d/nvidia-ml.list \
    && rm -f /etc/apt/sources.list.d/cuda.list

ENV TENSORRT_VERSION ${TENSORRT_VERSION}

RUN set -ex \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
       dialog apt-utils \
       sudo wget curl axel gdb xvfb zip git git-gui gitk libzip-dev libx11-dev \
       autoconf lsb-core \
       libglu1-mesa-dev freeglut3-dev mesa-common-dev \
       x11-apps mesa-utils htop valgrind mc bc net-tools screen iproute2 \
       build-essential libboost-dev libboost-program-options-dev libboost-all-dev \
       libssl-dev libcurl4-openssl-dev \
       libeigen3-dev uuid-dev libncurses5-dev \
       ffmpeg \
    && apt-get clean \
    && apt-get upgrade

RUN cd /usr/local/src \
    && curl -L -O https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0.tar.gz \
    && tar xvf cmake-3.22.0.tar.gz \
    && cd cmake-3.22.0 \
    && ./bootstrap \
    && make -j \
    && make install \
    && cd .. \
    && rm -rf cmake*

RUN cd /usr/local/src \
    && axel -n8 https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-gpu-linux-x86_64-1.15.0.tar.gz \
    && tar -C /usr/local -xzf libtensorflow-gpu-linux-x86_64-1.15.0.tar.gz \
    && rm libtensorflow-gpu-linux-x86_64-1.15.0.tar.gz

COPY build/installers /opt/apollo/installers
COPY build/rcfiles /opt/apollo/rcfiles

RUN mkdir -p /opt/apollo/rcfiles /opt/apollo/pkgs /opt/apollo/sysroot

RUN bash /opt/apollo/installers/install_dependencies.sh "${WORKHORSE}"

RUN set -ex \
    && apt-get update \
    && apt-get clean \
    && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

# Create user dev
RUN useradd -rm -d /home/dev -s /bin/bash -g root -G sudo -u 1001 dev

# Setup home environment
RUN cp /opt/apollo/installers/apollo.sh /etc/profile.d/apollo.sh
RUN mkdir /apollo && chown -R dev:root /apollo
RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Clean history
RUN rm -rf /root/.bash_history /home/dev/.bash_history

# Define default command.
CMD ["/bin/bash"]

USER dev
WORKDIR /home/dev