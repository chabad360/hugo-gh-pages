FROM alpine:3.10

ARG hugo_version

WORKDIR /tmp

# Deps
RUN apk add --no-cache \
      libstdc++ \
      libgcc \
      git \
      ca-certificates

# glibc...
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
      wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
      wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-bin-2.30-r0.apk && \
      wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-i18n-2.30-r0.apk && \
      apk add *.apk && \
      rm -rf ./*

# hugo
RUN wget https://github.com/gohugoio/hugo/releases/download/v${hugo_version}/hugo_extended_${hugo_version}_Linux-64bit.tar.gz && \
      tar zxvf hugo_extended_${hugo_version}_Linux-64bit.tar.gz && \
      chmod +x hugo && \
      mv hugo /usr/bin/hugo &&  \
      rm -rf ./*
