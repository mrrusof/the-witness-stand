FROM mrrusof/base-sandbox:build

RUN apk --no-cache add gcc musl-dev bsd-compat-headers

ENV SRC /tmp/main.c
ENV PRG /tmp/main.exe
ENV CMD gcc -pthread -o $PRG $SRC

CMD ["/compile.rb"]
