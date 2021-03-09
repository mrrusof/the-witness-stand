#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

interpreted_program=$(cat <<"EOF"
var endTime = new Date(new Date().getTime() + 3600000);
while(endTime > new Date()){}
EOF
)
