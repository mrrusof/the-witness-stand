#inline $INCLUDES_DIR/test-templates/run-compiled-timeout.bats

TIMEOUT=3

source_program=$(cat <<"EOF"
#include <thread>
#include <chrono>

using namespace std;

int main() {
  this_thread::sleep_for(chrono::seconds(3600));
  return 0;
}
EOF
)
