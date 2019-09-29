FROM alpine:3.10

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

LABEL "com.github.actions.name"="Hugo gh-pages action"
LABEL "com.github.actions.description"="GitHub Actions for building with hugo and pushing to gh-pages"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/chabad360/actions-hugo"
LABEL "homepage"="https://github.com/chabad360/actions-hugo"
LABEL "maintainer"="chabad360"

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
