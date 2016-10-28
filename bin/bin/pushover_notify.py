#!/usr/bin/env python

import sys
import httplib
import urllib
from config import PUSHOVER_TOKEN, PUSHOVER_USER

# Accept External Arguments
"""
1   The final directory of the job (full path)
./pushover-notify.py "message"

"""
# Pushover Notification Function
def pushmsg(title, msg, url_title='', url=''):
    conn = httplib.HTTPSConnection("api.pushover.net:443")
    conn.request("POST", "/1/messages.json",
      urllib.urlencode({
        "token": PUSHOVER_TOKEN,
        "user": PUSHOVER_USER,
        "title": title,
        "message": msg,
        "url_title": url_title,
        "url": url,
      }), { "Content-type": "application/x-www-form-urlencoded" })
    conn.getresponse()

if len(sys.argv) > 1:
    title = "Message from pushover-notify.py"
    pushmsg(title,sys.argv[1])
else:
    print "Error: you must specify a message to send"
    sys.exit(1)
