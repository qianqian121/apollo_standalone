FROM nvidia/cudagl:10.0-devel-ubuntu18.04

ARG WORKHORSE="cpu"
ENV DEBIAN_FRONTEND=noninteractive

# Set default shell to bash
RUN ln -sf /bin/bash /bin/sh

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
       libeigen3-dev uuid-dev \
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

RUN dpkg -i /opt/apollo/installers/libcudnn7_7.6.5.32-1+cuda10.0_amd64.deb \
    && rm /opt/apollo/installers/libcudnn7_7.6.5.32-1+cuda10.0_amd64.deb

RUN mkdir -p /opt/apollo/rcfiles /opt/apollo/pkgs /opt/apollo/sysroot

RUN bash /opt/apollo/installers/install_dependencies.sh "${WORKHORSE}"

RUN set -ex \
    && apt-get update \
    && apt-get clean \
    && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

# Create user dev
RUN useradd -ms /bin/bash dev && \
          echo "dev:dev" | chpasswd

# Setup home environment
RUN chown -R dev:dev /home/dev
RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Clean history
RUN rm -rf /root/.bash_history /home/dev/.bash_history

# Define default command.
CMD ["/bin/bash"]

USER dev