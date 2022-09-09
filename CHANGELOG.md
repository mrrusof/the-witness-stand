# Unreleased

- Upgrade base image to Ruby 3.1.2 but skip Javascript test copy-fds.
- Test reading 1M ints for Python sandbox.

# 0.18.0 2021.09.27

- Ouput debug information when env var TWS_DEBUG=true.
- Harness efficiently reads output fds.

# 0.17.0 2021.03.11

- Add JSDOM to Javascript sandbox.

# 0.16.0 2021.03.09

- Create Javascript sandbox.
- Upgrade Ruby in base image to 2.7.2.

# 0.15.0 2021.01.21

- [hack] Install SQLite in Python-based sandboxes.

# 0.14.0 2020.09.21

- Accept input/output fds/files.
- Use jq instead of jshon.
- Use Kernel#spawn instead of Open3.capture3 in harness.
- Declare abstract methods of harness.

# 0.13.0 2020.08.07

- Create scipy sandbox that also includes numpy and pandas too.
- Base image for Python from Debian Buster Slim w/o numpy.

# 0.12.0 2020.08.04

- Upgrade Python 2.7 to Python 3.
- Install numpy in Python sandbox.

# 0.11.0 2020.06.21

- Handle multiple classes in Java.

# 0.10.0 2020.06.10

- Rename input/output json fields.
- Indicate in CLI usage that container name is optional.

# 0.9.1 2020.06.08

- Inline test dependencies once.
- Use variable interpreted_program in tests.

# 0.8.0 Unreleased

- Rename compile input_json.source -> input_json.sourceProgram.

# 0.7.2 Unreleased

- Fix no internet tests.
- Revamp tests.
- Rename binary/interpreted output_json.actualOutput -> output_json.programOutput

# 0.6.2 Unreleased

- Test that each c/cpp positive compile test runs.
- Only test that compile output JSONs are well-formed.
- Separate binary sandbox in c-binary and cpp-binary sandboxes.
- Don't push when first CHANGELOG title is not a release version.
- Fix C and C++ compile tests.
- Fix typo in usage.
- Bump ruby-json version from 2.4.4-r0 to 2.4.6-r0 in base image.

# 0.5.0 2018.07.09

- Create C++ sandbox.

# 0.4.0 2018.06.11

- Update C tests for version change binutils 2.28-r3-> 2.30-r1.

# 0.3.0 2018.05.22

- CLI auto-generates container name when none is given.

# 0.2.0 2018.05.20

- OCaml sandbox interprets programs that use module Str.

# 0.1.0 2018.05.15

- Create sandboxes and CLI.
