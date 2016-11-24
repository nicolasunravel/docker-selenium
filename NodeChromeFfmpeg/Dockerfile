FROM unravel/node-chrome:2.53.1
MAINTAINER Selenium <selenium-developers@googlegroups.com>

USER root

#=====
# VNC
#=====
RUN apt-get update -qqy \
  && apt-get -qqy install \
    x11vnc \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p ~/.vnc \
  && x11vnc -storepasswd secret ~/.vnc/passwd

#=================
# Locale settings
#=================
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    language-pack-en \
  && rm -rf /var/lib/apt/lists/*

#=======
# Fonts
#=======
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
  && rm -rf /var/lib/apt/lists/*

#=========
# fluxbox
# A fast, lightweight and responsive window manager
#=========
RUN apt-get update -qqy \
  && apt-get -qqy install \
    fluxbox \
  && rm -rf /var/lib/apt/lists/*

##=========
## Build FFMPEG
##=========
## Set Locale
#RUN locale-gen en_US.UTF-8
#ENV LANG en_US.UTF-8
#ENV LANGUAGE en_US:en
#ENV LC_ALL en_US.UTF-8
#
## Enable Universe and Multiverse and install dependencies.
##RUN echo deb http://archive.ubuntu.com/ubuntu precise universe multiverse >> /etc/apt/sources.list; \
#RUN apt-get update; \
#    apt-get -y install autoconf automake build-essential git mercurial cmake libass-dev libgpac-dev libtheora-dev libtool libvdpau-dev libvorbis-dev pkg-config texi2html zlib1g-dev libmp3lame-dev wget yasm openssl libssl-dev; \
#    apt-get clean
#
## Run build script
#ADD ./build_ffmpeg.sh /build_ffmpeg.sh
#RUN ["/bin/bash", "/build_ffmpeg.sh"]

#===========================
# video recording capability
#===========================
RUN apt-get -qqy update && apt-get install -qqy wget
RUN wget http://repo1.maven.org/maven2/com/aimmac23/selenium-video-node/2.1/selenium-video-node-2.1.jar


#==============================
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh /opt/bin/entry_point.sh
RUN chmod +x /opt/bin/entry_point.sh

EXPOSE 5900
