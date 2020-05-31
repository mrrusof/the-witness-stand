#inline c-timeout-preamble.bash

function input_source {
  cat <<EOF
#include <unistd.h>

int main() {
  sleep(3600);
}
EOF
}
