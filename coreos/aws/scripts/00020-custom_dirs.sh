#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
DIRS_FOR_CORE="
    /etc/eurostar
"
mkdir -p $DIRS_FOR_CORE
for dir in $DIRS_FOR_CORE; do
    chown core:core $dir
done
