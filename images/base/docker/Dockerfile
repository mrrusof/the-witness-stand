FROM alpine:3.12

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apk add --no-cache ruby=2.7.4-r0 ruby-json=2.7.4-r0 dumb-init

COPY *.rb /

ENTRYPOINT ["dumb-init"]
