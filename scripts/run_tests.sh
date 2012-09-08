#!/bin/bash

REPO_ROOT="$(git rev-parse --show-toplevel)"
TEST_DIR="$REPO_ROOT/test"

JASMINE="$REPO_ROOT/node_modules/.bin/jasmine-node --color --coffee"

$JASMINE "$TEST_DIR"

exit $?
