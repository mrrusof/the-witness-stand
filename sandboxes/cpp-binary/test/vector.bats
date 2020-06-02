#inline images.bash
#inline $INCLUDES_DIR/return-binary.bats

function input_source {
  cat <<EOF
#include <vector>
#include <stdio.h>

using namespace std;

int main() {
  vector<int> nn;
  for(int i = 0; i < 10; i++) {
    nn.push_back(i);
  }
  printf("vector size is %d\n", nn.size());
  return 0;
}
EOF
}

function expected_output {
  cat <<"EOF"
vector size is 10
EOF
}

