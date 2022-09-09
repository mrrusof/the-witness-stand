FROM mrrusof/base-sandbox:build

RUN apk --no-cache add nodejs npm \
 && cd /tmp \
 && npm install jsdom

ENV PRG /tmp/main.js
ENV CMD node $PRG

CMD ["/run_interpreted.rb"]
