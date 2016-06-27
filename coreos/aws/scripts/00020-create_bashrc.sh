#!/bin/bash
#
# cp .bashrc to user's home dirs
USERS="root core"
TMP_FILE=/tmp/uploads/home_dir_assets/.bashrc

for user in $USERS; do
    home_dir=$(eval echo "~$user")
    primary_group=$(id -gn $user)
    echo "$0 INFO: adding .bashrc in $home_dir for $user"
    [[ -e $home_dir/.bashrc ]] && rm $home_dir/.bashrc
    cp $TMP_FILE $home_dir/.bashrc
    chown $user:$primary_group $home_dir/.bashrc
done
