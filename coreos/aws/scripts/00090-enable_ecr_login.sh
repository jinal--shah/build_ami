#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# 00090-enable_ecr_login.sh
#
# enable systemd timer to freshen creds for ecr
#
# This only checks that the timer is installed
# - it doesn't check that the service is working!
#    
TIMER=ecr_login
systemctl enable $TIMER.timer
systemctl daemon-reload
if ! systemctl start $TIMER.timer
then
    echo "$0 ERROR: could not start up $TIMER.timer." >&2
    exit 1
fi

