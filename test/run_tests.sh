#!/bin/bash

FNAME_PATTERN='spec'

REPO_ROOT="$(git rev-parse --show-toplevel)"
TEST_DIR="$REPO_ROOT/test"
RUN_APP='cd "$REPO_ROOT"; npm start'

JASMINE="$REPO_ROOT/node_modules/.bin/jasmine-node"


HL='\033[0;37m'; RESET='\033[0m'


echo -e "$HL------------ unit ------------$RESET"
"$JASMINE" --color --coffee "$TEST_DIR/unit"

echo -e "$HL------------ app -------------$RESET"

sh -c "$RUN_APP &> '$TEST_DIR/app/last_run.log'" &
SERVER_PID=$!
sleep 2 # start-up

"$JASMINE" --color --coffee "$TEST_DIR/app"

kill $SERVER_PID