FROM mrrusof/base-sandbox:build

RUN apk --no-cache add g++

ENV SRC /tmp/main.cpp
ENV PRG /tmp/main.exe
ENV CMD g++ -pthread -o $PRG $SRC

CMD ["/compile.rb"]
