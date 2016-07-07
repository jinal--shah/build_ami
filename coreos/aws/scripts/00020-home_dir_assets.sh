#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# 00020-home_dir_assets.sh
#
# make custom executables and .bashrc available
# to users core
#
# make .bashrc available to root as well
#
USERS="root core"
TMP_DIR=/tmp/uploads/home_dir_assets

# ... all bin dir assets should be executable
find $TMP_DIR -type f | grep '/bin/' | xargs -n1 -i{} chmod a+x {}


# ... cp .bashrc
for user in $USERS; do
    home_dir=$(eval echo "~$user")
    primary_group=$(id -gn $user)

    # ... move common assets to all users' home dirs
    echo "$0 INFO: ... moving common assets to $user's home dir."
    chown -R $user:$primary_group $TMP_DIR/common
    /bin/cp -r $TMP_DIR/common/. $home_dir/

    # move any specific user assets to home
    if [[ -d "$TMP_DIR/$user" ]]; then
        echo "$0 INFO: ... moving specific assets for $user to home dir"
        chown -R $user:$primary_group $TMP_DIR/$user
        /bin/cp -r $TMP_DIR/$user/. $home_dir/
    fi

done
