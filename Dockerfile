FROM chabad360/hugo

RUN apk add --update --no-cache openssl git && \
  rm -rf /var/cache/apk/*

COPY ./docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
