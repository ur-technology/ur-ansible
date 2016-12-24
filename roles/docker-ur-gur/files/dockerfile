FROM ubuntu:16.04

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed'
# error message when installing any other package with the apt-get package manager.
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    dnsutils \
    git \
    golang \
    inetutils-ping \
    libgmp3-dev

RUN adduser --disabled-password --gecos "" deploy && usermod -aG sudo deploy
USER deploy
WORKDIR /home/deploy

RUN mkdir ur_data
RUN mkdir .ethash

EXPOSE 9595 19595 19595/udp
