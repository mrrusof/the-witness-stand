function usage {
  cmd=`basename $0`
  cat <<EOF
Usage:
  $cmd <SANDBOX> <CONTAINER_NAME>
  $cmd <option>

Options:
  -l,--download      Download Docker image for each sandbox.
  -l,--list          List available sandboxes.
  -v,--version       Print version.
  -h,--help          You are looking at it.
EOF
}
