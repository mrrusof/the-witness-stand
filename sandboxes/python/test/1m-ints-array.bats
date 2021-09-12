#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

TIMEOUT=30

interpreted_program=$(cat <<'EOF'
import re
import sys
def identity(a):
  return a
input_obj = open(100, mode='r', newline='')
output_obj = open(101, mode='w', newline='')

def read_int():
  global input_obj
  return int(input_obj.readline())

def read_flat_array(ty):
  global input_obj
  size = int(input_obj.readline())
  result = [None] * size
  read_fun = globals()['read_%s' % ty]
  for i in range(size):
    result[i] = read_fun()
  return result

def print_int(v):
  output_obj.write(str(v))

def print_flat_array(ty, vv):
  if not vv:
    output_obj.write('[]')
    return
  output_obj.write('[')
  print_fun = globals()['print_%s' % ty]
  print_fun(vv[0])
  for v in vv[1:]:
    output_obj.write(', ')
    print_fun(v)
  output_obj.write(']')

a = read_flat_array('int')
return_value = identity(a)

print_flat_array('int', return_value)
input_obj.close()
output_obj.close()
EOF
)

input_fds[100]=$(cat $INCLUDES_DIR/data/1m-ints.uva)

expected_output_fds[101]=$(cat $INCLUDES_DIR/data/1m-ints.ruby)
