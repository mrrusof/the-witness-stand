#inline $INCLUDES_DIR/test-templates/run-interpreted-positive.bats

interpreted_program=$(cat <<'EOF'
import re
import sys

def equilibrium_indices(a):
  if len(a) == 0:
    return []
  ls = 0
  rs = sum(a)
  r = []
  i = 0
  for e in a:
    rs -= e
    if ls == rs:
      r.append(i)
    ls += e
    i += 1
  return r

input_obj = open(100, mode='r', newline='')
output_obj = open(101, mode='w', newline='')

input = input_obj.read()
pos = 0

def scan(p):
  global input
  global pos
  m = p.match(input, pos)
  if not m:
    return None
  pos += m.end() - m.start()
  return m.group(0)

def skip_whitespace():
  if not hasattr(skip_whitespace, 'p'):
    skip_whitespace.p = re.compile('\s*')
  scan(skip_whitespace.p)

def next_word():
  if not hasattr(next_word, 'p'):
    next_word.p = re.compile('\S+')
  skip_whitespace()
  return scan(next_word.p)

def read_int():
  if not hasattr(read_int, 'p'):
    read_int.p = re.compile('-{0,1}[0-9]+')
  skip_whitespace()
  s = scan(read_int.p)
  if not s:
    s = next_word() or ''
    sys.exit('unknown int format: %s' % s)
  return int(s)

def read_flat_array(ty):
  if not hasattr(read_flat_array, 'left'):
    read_flat_array.left = re.compile('\\[')
    read_flat_array.comma_or_right = re.compile('[,\\]]')
    read_flat_array.right = re.compile('\\]')
  skip_whitespace()
  s = scan(read_flat_array.left)
  if not s:
    s = next_word() or ''
    sys.exit('expected beginning of flat %s array: %s' % (ty, s))
  skip_whitespace()
  s = scan(read_flat_array.right)
  if s:
    return []
  array = []
  while s != ']':
    read_fun = globals()['read_%s' % ty]
    element = read_fun()
    array.append(element)
    skip_whitespace()
    s = scan(read_flat_array.comma_or_right)
    if not s:
      s = next_word() or ''
      sys.exit('expected comma or end of flat %s array: %s' % (ty, s))
  return array

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
skip_whitespace()
s = input[pos:]
if s:
  sys.exit("unread stdin data: '%s'" % s)

# return_value = equilibrium_indices(a)
return_value = a

print_flat_array('int', return_value)
input_obj.close()
output_obj.close()
EOF
)

input_fds[100]=$(cat $INCLUDES_DIR/data/1m-ints.ruby)

expected_output_fds[101]=$(cat $INCLUDES_DIR/data/1m-ints.ruby)
