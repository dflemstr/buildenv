FROM ubuntu:16.04

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
COPY create-links /root/create-links
RUN /root/create-links && rm /root/create-links

WORKDIR /home/build
USER build
