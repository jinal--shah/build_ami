#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
USERS="root core"

for user in $USERS; do
    home_dir=$(eval echo "~$user")
    primary_group=$(id -gn $user)
    echo "$0 INFO: creating .alias dir in $home_dir for $user"
    mkdir -p $home_dir/.alias
    chown $user:$primary_group $home_dir/.alias
done

mkdir -p /etc/eurostar
chown core:core /etc/eurostar
