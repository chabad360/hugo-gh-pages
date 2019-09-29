FROM registry.gitlab.com/pages/hugo/hugo_extended:latest

RUN apk add --update --no-cache ca-certificates openssl git && \
  rm -rf /var/cache/apk/*

LABEL "com.github.actions.name"="Hugo gh-pages action"
LABEL "com.github.actions.description"="GitHub Actions for building with hugo and pushing to gh-pages"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/chabad360/actions-hugo"
LABEL "homepage"="https://github.com/chabad360/actions-hugo"
LABEL "maintainer"="chabad360"

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
