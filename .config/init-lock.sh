#!/bin/sh
export XSECURELOCK_AUTH_BACKGROUND_COLOR="#1e1e2e"
export XSECURELOCK_AUTH_FOREGROUND_COLOR="#cdd6f4"
export XSECURELOCK_AUTH_CURSOR_BLINK=0
export XSECURELOCK_AUTH_SOUNDS=0
export XSECURELOCK_DATETIME_FORMAT="%H:%M"
export XSECURELOCK_BLANK_DPMS_STATE=off
export XSECURELOCK_BLANK_TIMEOUT=0

xset s 300
xset dpms 250 300 350

# Locker wrapper: skip locking (and reset the idle timer) 
# if audio is actively playing (e.g. YouTube in Firefox, VLC, etc.)
xss-lock --transfer-sleep-lock -- sh -c '
    if wpctl status 2>/dev/null | grep -qF "[active]"; then
        xset s reset
    else
        exec xsecurelock
    fi
' &
