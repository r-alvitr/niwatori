#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

apt-get update && \
    apt-get install -y supervisor xfce4 xfce4-terminal xterm git vim wget net-tools bzip2 python-numpy libnss-wrapper gettext && \
    apt-get install -y --no-install-recommends curl ca-certificates fontconfig && \
    apt-get purge -y pm-utils xscreensaver*
    apt-get clean -y
