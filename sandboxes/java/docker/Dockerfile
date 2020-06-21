FROM mrrusof/java-base-sandbox:build

ENV PRG /tmp/compiled_program.tar.gz
ENV PRE cd /tmp && tar -xzf compiled_program.tar.gz
ENV CMD java -cp /tmp Main

CMD ["/run_compiled.rb"]
