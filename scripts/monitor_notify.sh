#!/bin/bash
URL=https://www.example.com
NOTIFYEMAIL=user1@example.com
NOTIFYEMAIL2=user2@example.com

curl -sSf $URL > /dev/null
if [ $? -ne 0 ]
then
# Use your favorite mailer here:
echo "$URL is down" | mailx -a "From: Uptime Monitor <monitor@example.com>" -s "Server $URL is down" "$NOTIFYEMAIL"
echo "$URL is down" | mailx -a "From: Uptime Monitor <monitor@example.com>" -s "Server $URL is down" "$NOTIFYEMAIL2"
fi
