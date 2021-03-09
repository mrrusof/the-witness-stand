FROM mrrusof/base-sandbox:build

RUN apk --no-cache add nodejs

ENV PRG /tmp/main.js
ENV CMD node $PRG

CMD ["/run_interpreted.rb"]
