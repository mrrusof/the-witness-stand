function available_sandboxes {
  cat <<EOF
c
c-binary
cpp
cpp-binary
elixir
java
javac
ocaml
python
ruby
scipy
EOF
}

function download_sandboxes {
  for s in `available_sandboxes`; do
    docker pull ${DOCKER_IMAGE_PREFIX}$s-sandbox${DOCKER_IMAGE_SUFFIX}
  done        
}
