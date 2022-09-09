FROM alpine:3.16

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apk add --no-cache ruby=3.1.2-r0 ruby-json=3.1.2-r0 dumb-init

COPY *.rb /

ENTRYPOINT ["dumb-init"]
