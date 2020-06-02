#inline images.bash
#inline $INCLUDES_DIR/runtime-error-binary.bats

function input_source {
  cat <<EOF
void this_wont_end_well(int n) {
  this_wont_end_well(n + 1);
}

int main() {
  this_wont_end_well(0);
}
EOF
}

EXP_EC=11
