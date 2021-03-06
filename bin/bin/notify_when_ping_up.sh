#!/bin/sh
# -------------------------------------------------------------------------
# ping a host every 5 seconds or so and notify me when it's back online.
# -------------------------------------------------------------------------

if [ $# -eq 0 ]; then
	echo "ERROR: You must specify a host address to ping."
        exit 1
fi

MYHOST=$1

while :; do
	ping -c 1 -w 1 $MYHOST
        if [ $? -ne 0 ]; then
                echo "sleeping."
        else
                echo "$MYHOST is back online."
 		$HOME/bin/pushover_notify.py "$MYHOST is back online."
                exit 0
        fi
        sleep 5
done
