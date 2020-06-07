#inline $INCLUDES_DIR/test-templates/run-interpreted-timeout.bats

source_program=$(cat <<"EOF"
threads = []
10000.times do
  threads << Thread.new do
    i = 0
    while true
      i += 1
    end
  end
end

threads.each { |t| t.join }
EOF
)
