#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# 00020-home_dir_assets.sh
#
# make custom executables and .bashrc available
# to users root and core
#
USERS="root core"
TMP_DIR=/tmp/uploads/home_dir_assets
HOME_BIN=$TMP_DIR/bin

chmod a+x $HOME_BIN/*

for user in $USERS; do
    home_dir=$(eval echo "~$user")
    primary_group=$(id -gn $user)
    [[ -e $home_dir/.bashrc ]] && rm $home_dir/.bashrc
    chown -R $user:$primary_group $TMP_DIR
    cp -r $TMP_DIR/. $home_dir
done
