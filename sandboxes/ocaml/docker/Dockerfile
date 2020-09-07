FROM mrrusof/base-sandbox:build

RUN apk add --no-cache ocaml ocaml-compiler-libs
RUN ocamlmktop -thread unix.cma threads.cma str.cma -o ocaml_threads

ENV PRG /tmp/main.ml
ENV CMD /ocaml_threads -I +threads $PRG

CMD ["/run_interpreted.rb"]