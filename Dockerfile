FROM ubuntu:18.04

# headless vnc
## Connection ports for controlling the UI:
#  - VNC port:5901
#  - noVNC webport, connect via http://IP:6901/?password=vncpassword
ENV DISPLAY=:1 \
  VNC_PORT=5901 \
  NO_VNC_PORT=6901
EXPOSE $VNC_PORT $NO_VNC_PORT

## Envrionment config
ENV HOME=/headless \
  TERM=xterm \
  STARTUPDIR=/dockerstartup \
  INST_SCRIPTS=/headless/install \
  NO_VNC_HOME=/headless/noVNC \
  DEBIAN_FRONTEND=noninteractive \
  VNC_COL_DEPTH=24 \
  VNC_RESOLUTION=1280x1024 \
  VNC_PW=vncpassword \
  VNC_VIEW_ONLY=false

WORKDIR ${HOME}

## Add all install scripts
ADD ./src/install ${INST_SCRIPTS}/
RUN find ${INST_SCRIPTS} -name '*.sh' -exec chmod a+x {} +

## Install common tools 
RUN ${INST_SCRIPTS}/tools.sh

## Install xvnc-server, noVNC-HTML5 based VNC viewer
RUN ${INST_SCRIPTS}/tigervnc.sh && ${INST_SCRIPTS}/no_vnc.sh

## xfce
ADD ./src/xfce ${HOME}/

## config setup
RUN echo 'source $STARTUPDIR/generate_container_user' >> $HOME/.bashrc
ADD ./src/scripts ${STARTUPDIR}
RUN ${INST_SCRIPTS}/set_user_permission.sh ${STARTUPDIR} ${HOME}

## config jdk
RUN ${INST_SCRIPTS}/setup_jdk.sh
ENV JAVA_VERSION jdk-11.0.5+10
ENV JAVA_HOME=/opt/java/openjdk \
  PATH="/opt/java/openjdk/bin:$PATH"

## download Minecraft
RUN curl -O https://launcher.mojang.com/download/Minecraft.deb

## input-over-ssh
RUN git clone https://millenary.net/gitlab/ymgtech/input-over-ssh.git

## Python

USER 0

ENTRYPOINT [ "/dockerstartup/vnc_startup.sh" ]
CMD ["--wait"]
