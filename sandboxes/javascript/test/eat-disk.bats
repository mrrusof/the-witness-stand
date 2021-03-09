#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

interpreted_program=$(cat <<"EOF"
const { exec } = require('child_process');

exec("dd if=/dev/urandom of=/tmp/trash bs=1M count=1048576",
     (error, stdout, stderr) => { console.log('done'); });
EOF
)

