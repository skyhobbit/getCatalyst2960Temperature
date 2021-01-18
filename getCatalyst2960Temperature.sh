#!/bin/sh
THRESHOLD=50
IPADDRESSES=("192.168.0.52" "192.168.0.53")
CID=public

date

for IPADDRESS in ${IPADDRESSES[@]}
do
  TEMPERATURE=`snmpget -v 2c -c ${CID} ${IPADDRESS} .1.3.6.1.4.1.9.9.13.1.3.1.3.1008 | awk 'END{print $NF}'`
  if [[ "${TEMPERATURE}" =~ ^[0-9]+$ ]] ; then
    echo "$IPADDRESS $TEMPERATURE"
    if [ $TEMPERATURE -ge $THRESHOLD ] ; then
      say "${TEMPERATURE}"
    fi
  fi
done
