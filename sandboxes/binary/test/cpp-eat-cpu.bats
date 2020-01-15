#inline cpp-timeout-preamble.bash

function input_source {
  cat <<EOF
#include <thread>

using namespace std;

void thread_main() {
  int j = 0;
  while(1) {
    j++;
  }
}

int main() {
  int thread_count = 10000;
  int i;
  thread *tt[thread_count];
  for(i = 0; i < thread_count; i++) {
    tt[i] = new thread(thread_main);
  }
  for(i = 0; i < thread_count; i++) {
    tt[i]->join();
  }
  return 0;
}
EOF
}