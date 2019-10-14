FROM registry.gitlab.com/pages/hugo/hugo_extended:latest

RUN apk add --update --no-cache ca-certificates openssl git && \
  rm -rf /var/cache/apk/*

# Hugo External Dependecies (add py3-rst once its out of testing)
RUN apk add --update --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing py-pygments asciidoctor npm py3-rst \
  && rm -rf /var/cache/apk/* \
  && npm config set unsafe-perm true \
  && npm install -g postcss-cli \
  && npm config set unsafe-perm false \
  && wget https://github.com/jgm/pandoc/releases/download/2.7.3/pandoc-2.7.3-linux.tar.gz \
  && tar xvzf pandoc-2.7.3-linux.tar.gz --strip-components 1 -C /usr/local \
  && rm pandoc-2.7.3-linux.tar.gz \
  && mkdir /site

COPY ./entrypoint.sh /entrypoint.sh

WORKDIR /site

VOLUME [ "/site" ]

CMD [ "hugo", "-h" ]
