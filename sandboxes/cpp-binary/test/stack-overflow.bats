#inline $INCLUDES_DIR/test-templates/run-compiled-runtime-error.bats

source_program=$(cat <<"EOF"
void this_wont_end_well(int n) {
  this_wont_end_well(n + 1);
}

int main() {
  this_wont_end_well(0);
}
EOF
)

expected_exit_code=11
