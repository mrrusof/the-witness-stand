FROM python:3.8-slim

LABEL maintainer ruslanledesmagarza@gmail.com

RUN    apt-get update \
    && apt-get install -y time ruby-json=2.1.0+dfsg-2+deb10u1 dumb-init \
    && apt-get clean

COPY *.rb /

ENTRYPOINT ["dumb-init"]
