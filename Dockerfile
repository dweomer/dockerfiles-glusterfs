ARG UBUNTU=bionic

FROM ubuntu:${UBUNTU} AS glusterfs-client

ARG UBUNTU
ARG GLUSTERFS=4.1

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install --assume-yes \
    gnupg \
 && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 13E01B7B3FE869A9 \
 && echo "deb http://ppa.launchpad.net/gluster/glusterfs-${GLUSTERFS}/ubuntu ${UBUNTU} main" > /etc/apt/sources.list.d/gluster-ppa.list \
 && apt-get update \
 && apt-get install --assume-yes \
    glusterfs-client \
    xz-utils \
 && glusterfs --version


FROM glusterfs-client AS glusterfs-server

RUN set -x \
 && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install --assume-yes \
    glusterfs-server \
 && gluster --version
