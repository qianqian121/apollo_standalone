FROM nvidia/cudagl:10.0-devel-ubuntu18.04

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
       sudo

# Create user dev
RUN useradd -rm -d /home/dev -s /bin/bash -g root -G sudo -u 1001 dev

# Setup home environment
RUN mkdir /apollo && chown -R dev:root /apollo
RUN echo "dev ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Clean history
RUN rm -rf /root/.bash_history /home/dev/.bash_history

# Define default command.
CMD ["/bin/bash"]

USER dev
WORKDIR /home/dev