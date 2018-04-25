FROM mrrusof/base-sandbox:build

RUN apk --no-cache add elixir

ENV PRG /tmp/main.exs
ENV CMD elixir $PRG

CMD ["/run_interpreted.rb"]
