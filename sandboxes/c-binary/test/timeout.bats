#inline $INCLUDES_DIR/test-templates/run-compiled-timeout.bats

TIMEOUT=3

source_program=$(cat <<"EOF"
#include <unistd.h>

int main() {
  sleep(3600);
}
EOF
)
