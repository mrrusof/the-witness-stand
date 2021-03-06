#inline $INCLUDES_DIR/test-templates/compile-positive.bats

source_program=$(cat <<"EOF"
#include <iostream>
#include <thread>

using namespace std;

void thread_main() {
  cout << "thread does some work\n";
}

int main(int argc, char **argv) {
  thread thread1(thread_main);
  cout << "waiting for thread\n";
  thread1.join();
  cout << "thread is done\n";
  return 0;
}
EOF
)

