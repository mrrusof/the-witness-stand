FROM mrrusof/base-sandbox:build

RUN apk add --no-cache libstdc++ # for c++

ENV PRG /tmp/main.exe
ENV CMD $PRG

CMD ["/run_binary.rb"]
