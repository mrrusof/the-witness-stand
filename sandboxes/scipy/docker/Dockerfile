FROM mrrusof/python-base-sandbox:build

RUN pip install --no-cache-dir scipy pandas

ENV PRG /tmp/main.py
ENV CMD python3 $PRG

CMD ["/run_interpreted.rb"]
