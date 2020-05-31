#inline cpp-timeout-preamble.bash

function input_source {
  cat <<EOF
#include <stdlib.h>

int main() {
  system("dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576");
}
EOF
}
