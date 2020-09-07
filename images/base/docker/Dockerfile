FROM alpine:3.12

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apk add --no-cache ruby=2.7.1-r3 ruby-json=2.7.1-r3 dumb-init

COPY *.rb /

ENTRYPOINT ["dumb-init"]
