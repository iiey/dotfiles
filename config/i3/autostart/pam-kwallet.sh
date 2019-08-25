#!/bin/bash
#script is used to unlock kwallet automatically in i3
#it tries to open kwallet at start with the same password as login

if [ "$DESKTOP_SESSION" == "i3" ]; then
    /usr/share/libpam-kwallet-common/pam_kwallet_init
fi
