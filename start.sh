#!/bin/sh

python -m SimpleHTTPServer 3000 &
STATIC_PID=$!
q life.q -p 5000 </dev/null &
WS_PID=$!

touch life.pid
echo "$STATIC_PID\n$WS_PID" > life.pid
