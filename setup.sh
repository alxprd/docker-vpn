#!/bin/bash

mkdir -p ./conf
rm -f ./conf/static.key
docker run --rm alxprd/vpn generate_key > ./conf/static.key
echo "Static key generated inside conf/static.key"