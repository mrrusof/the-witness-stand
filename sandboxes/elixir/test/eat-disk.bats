#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

interpreted_program='System.cmd("dd", ["if=/dev/urandom", "of=/tmp/trash", "bs=1M", "count=1048576"])'
