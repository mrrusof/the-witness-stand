function fail {
  echo ERROR: "$*" 1>&2
  return 1   
}
