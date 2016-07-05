#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# 00090-enable_ecr_login.sh
#
# enable systemd timer to freshen creds for ecr
#
TIMER=ecr_login
systemctl daemon-reload
systemctl enable $TIMER.timer
if ! systemctl start $TIMER.timer
then
    echo "$0 ERROR: could not start up $TIMER.timer." >&2
    exit 1
fi

systemctl list-timers $TIMER.timer
