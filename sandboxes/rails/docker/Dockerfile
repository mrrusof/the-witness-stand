FROM mrrusof/base-sandbox:build

RUN apk add --no-cache build-base ruby-dev \
 && gem install rails

ENV PRG /tmp/main.rb
ENV CMD ruby $PRG

CMD ["/run_interpreted.rb"]
