#inline timeout-preamble.bash

function input_source {
  cat <<EOF
#include <thread>
#include <chrono>

using namespace std;

int main() {
  this_thread::sleep_for(chrono::seconds(3600));
  return 0;
}
EOF
}
