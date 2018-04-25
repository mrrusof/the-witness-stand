FROM mrrusof/base-sandbox:build

RUN apk --no-cache add python

ENV PRG /tmp/main.py
ENV CMD python $PRG

CMD ["/run_interpreted.rb"]
