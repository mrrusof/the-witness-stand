#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

interpreted_program=$(cat <<"EOF"
#load "unix.cma";;
Unix.sleep 3600;;
EOF
)
