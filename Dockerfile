FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y pulseaudio libpulse-dev git
RUN echo "deb-src http://archive.ubuntu.com/ubuntu/ focal main restricted" >> /etc/apt/sources.list
RUN apt-get update && apt-get build-dep -y pulseaudio && apt-get source pulseaudio
WORKDIR /pulseaudio-13.99.1
RUN ./configure
WORKDIR /
RUN git clone --depth 1 https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
WORKDIR /pulseaudio-module-xrdp
RUN ./bootstrap && ./configure PULSE_DIR=/pulseaudio-13.99.1 && make && make install
WORKDIR /pulseaudio-module-xrdp/src/.libs
RUN tar zcf /pulseaudio-module-xrdp-ubuntu20.04.tar.gz *.so
WORKDIR /
