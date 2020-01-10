FROM ubuntu:18.04

ENV HOME=/alvitr \
  DEBIAN_FRONTEND=noninteractive \
  STARTUPDIR=/dockerstartup \
  INST_SCRIPTS=/alvitr/install \
  NO_VNC_home=/alvitr/noVNC

# add files
ADD ./src/xfce ${HOME}/
ADD ./src/scripts ${STARTUPDIR}/
ADD ./src/set_user_permission.sh ${INST_SCRIPTS}/
ADD ./src/set_jdk.sh ${INST_SCRIPTS}/

RUN apt-get update && \
  # install some tools
  apt-get install -y git wget curl supervisor xfce4 xfce4-terminal xterm libnss-wrapper gettext && \
  apt-get purge -y pm-utils xscreensaver* && \
  # tigervnc
  wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C / && \
  # noVNC
  mkdir -p ${NO_VNC_home}/utils/websockify && \
  wget -qO- https://github.com/novnc/noVNC/archive/v1.0.0.tar.gz | tar xz --strip 1 -C ${NO_VNC_home}/ && \
  wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C ${NO_VNC_home}/utils/websockify/ && \
  chmod +x -v ${NO_VNC_home}/utils/*.sh && \
  ln -s ${NO_VNC_home}/vnc_lite.html ${NO_VNC_home}/index.html && \
  # libnss_wrapper setup
  echo 'source $STARTUPDIR/generate_container_user' >> $HOME/.bashrc && \
  # config setup
  ${INST_SCRIPTS}/set_user_permission.sh ${STARTUPDIR} ${HOME} && \
  # jdk setup
  ${INST_SCRIPTS}/set_jdk.sh && \
  # minecraft
  curl -o ~/Downloads/Minecraft.deb https://launcher.mojang.com/download/Minecraft.deb && \
  # input over ssh
  cd ~/Downloads/ && \
  git clone https://millenary.net/gitlab/ymgtech/input-over-ssh.git && \
  # clean up
  apt-get clean -y

# env
ENV JAVA_VERSION jdk-11.0.5+10
ENV JAVA_HOME=/opt/java/openjdk PATH="/opt/java/openjdk/bin:$PATH"

USER 0
CMD /bin/bash
