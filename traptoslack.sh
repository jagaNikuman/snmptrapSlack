#!/bin/bash

# load $SLACK_URL, $SLACK_CHANNEL
CONFIGFILE="/etc/snmp/trapslack/config.sh"
source $CONFIGFILE

FILE="/tmp/trapslack"
#trap 'rm $FILE' 0
rm -rf $FILE
while read LINE; do
  echo $LINE >> $FILE
done
MESSAGE=`cat $FILE | sed 's/"/\\\\"/g'`
MESSAGE='```'${MESSAGE::2000}'```'

curl -sS -X POST --data-urlencode "payload={\"channel\": \"${SLACK_CHANNEL}\", \"text\": \"${MESSAGE}\"}" ${SLACK_URL}
