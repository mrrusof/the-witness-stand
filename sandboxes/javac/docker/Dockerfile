FROM mrrusof/java-base-sandbox:build

ENV SRC /tmp/Main.java
ENV PRG /tmp/compiled_program.tar.gz
ENV CMD javac -d /tmp $SRC
ENV PST cd /tmp && tar -czf compiled_program.tar.gz *.class

CMD ["/compile.rb"]
