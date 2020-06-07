#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

source_program=$(cat <<"EOF"
#load "unix.cma";;
Unix.sleep 3600;;
EOF
)
