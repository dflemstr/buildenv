FROM ubuntu:16.10

WORKDIR /root

COPY install-meta /root/install-meta
RUN /root/install-meta && rm /root/install-meta

WORKDIR /home/build
USER build
ARG target
RUN mkdir $target
COPY config/$target.config /home/build/$target/.config
COPY install /home/build/install
RUN /home/build/install $target && rm /home/build/install

WORKDIR /root
USER root
COPY install-post /root/install-post
RUN /root/install-post && rm /root/install-post

WORKDIR /build
