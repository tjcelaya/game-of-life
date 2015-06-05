#!/bin/sh
for l in `cat life.pid`; do kill $l; done
