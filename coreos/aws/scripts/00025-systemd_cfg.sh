#!/bin/bash
# vim: et sr sw=4 ts=4 smartindent:
#
# 00025-systemd_cfg.sh
#
# cp systemd services, timers and cfg
# to default /etc/systemd/system location.
#
# THIS SCRIPT DOES NOT ENABLE ANY OF THE SERVICES OR TIMERS
# It merely drops the config files.
#
TMP_DIR=/tmp/uploads/systemd
SYSTEMD_DIR=/etc/systemd/system

if [[ ! -d $TMP_DIR ]]; then
    echo "$0 ERROR: can't find $TMP_DIR to copy assets over to $SYSTEMD_DIR" >&2
    exit 1
fi

cp -r $TMP_DIR/* $SYSTEMD_DIR

