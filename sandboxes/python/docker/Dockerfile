FROM mrrusof/base-sandbox:build

RUN apk add --no-cache python3 py-numpy

ENV PRG /tmp/main.py
ENV CMD python3 $PRG

CMD ["/run_interpreted.rb"]
