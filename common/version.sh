#!/bin/bash

CHANGELOG=${0%/*}/../CHANGELOG.md

set -o pipefail

head -n 1 $CHANGELOG | \
    grep '\# [0-9]\+\.[0-9]\+\.[0-9]\+ [0-9]\{4\}\.[0-9]\{2\}\.[0-9]\{2\}' | \
    sed -e 's/\# *//' -e 's/ \+/-/' \
|| echo build
