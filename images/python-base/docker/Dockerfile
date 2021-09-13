FROM python:3.8-slim

LABEL maintainer ruslanledesmagarza@gmail.com

RUN    apt-get update \
    && apt-get install -y time ruby-json=2.3.0+dfsg-1+b3 dumb-init sqlite3 \
    && apt-get clean

COPY *.rb /

ENTRYPOINT ["dumb-init"]
