FROM alpine:3.7

LABEL maintainer ruslanledesmagarza@gmail.com

RUN apk --no-cache add ruby-json=2.4.4-r0
RUN apk --no-cache add dumb-init

COPY *.rb /

ENTRYPOINT ["dumb-init"]
