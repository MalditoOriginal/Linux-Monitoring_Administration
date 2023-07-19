FROM ubuntu:latest

RUN apt update && \
    apt upgrade -y && \
    apt install -y net-tools iproute2 bc && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /projects
WORKDIR /projects