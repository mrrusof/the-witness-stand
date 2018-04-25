function available_sandboxes {
  cat <<EOF
binary
c
elixir
java
javac
ocaml
python
ruby
EOF
}

function download_sandboxes {
  for s in `available_sandboxes`; do
    docker pull ${DOCKER_IMAGE_PREFIX}$s-sandbox${DOCKER_IMAGE_SUFFIX}
  done        
}
