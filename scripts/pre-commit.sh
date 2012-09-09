#!/bin/bash
# a git hook to be run before each commit
# how to install: link to .git/hooks/pre-commit

# run from the repo root
cd "$(git rev-parse --show-toplevel)"

# run tests
git stash -q --keep-index  # stash so that stuff not added to commit will not be tested
scripts/run_tests.sh
RESULT=$?
git stash pop -q  # pop stash
[[ $RESULT != 0 ]] && exit 1  # fail

exit 0
