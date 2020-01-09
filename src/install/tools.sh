#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install some common tools for further installation"
apt-get update && \
    apt-get install -y vim wget net-tools locales bzip2 python-numpy && \
    apt-get install -y --no-install-recommends curl ca-certificates fontconfig && \
    apt-get clean -y

echo "generate locales for en_US.UTF-8" && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen en_US.UTF-8 && rm -rf /var/lib/apt/lists/*
