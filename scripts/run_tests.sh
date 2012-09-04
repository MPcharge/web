#!/bin/bash

FNAME_PATTERN='spec'

REPO_ROOT="$(git rev-parse --show-toplevel)"
TEST_DIR="$REPO_ROOT/test"
RUN_APP='cd "$REPO_ROOT"; npm start'

JASMINE="$REPO_ROOT/node_modules/.bin/jasmine-node --color --coffee"


HL='\033[0;37m'; RESET='\033[0m'

echo -e "$HL------------ unit ------------$RESET"
$JASMINE "$TEST_DIR/unit"
STATUS=$?

[[ $STATUS != 0 ]] && exit $STATUS

echo -e "$HL------------ app -------------$RESET"

export PORT=4999

sh -c "$RUN_APP &> '$TEST_DIR/app/last_run.log'" &
sleep 2 # start-up

$JASMINE "$TEST_DIR/app"
STATUS=$?

killall -SIGINT foreman  # sorry, can't get PID to work...

[[ $STATUS != 0 ]] && exit $STATUS

exit 0
