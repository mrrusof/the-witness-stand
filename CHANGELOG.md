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
