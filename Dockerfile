FROM registry.gitlab.com/pages/hugo/hugo_extended:latest

RUN apk add --update --no-cache ca-certificates openssl git py-pygments && \
  rm -rf /var/cache/apk/*

LABEL "com.github.actions.name"="Hugo to GH Pages"
LABEL "com.github.actions.description"="GitHub Action for Build Hugo Site and Pushing it to Github Pages"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="red"

LABEL "repository"="https://github.com/chabad360/actions-hugo"
LABEL "homepage"="https://github.com/chabad360/actions-hugo"
LABEL "maintainer"="chabad360"

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
