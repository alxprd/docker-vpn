#!/bin/bash

rm -f ./conf/client.conf
echo "remote $1" >> ./conf/client.conf
cat ./conf/client-template.conf >> ./conf/client.conf

docker run --name vpn-client --rm --privileged -v $PWD/conf:/conf -d alxprd/vpn start_client
