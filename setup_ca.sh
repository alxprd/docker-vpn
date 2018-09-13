#!/bin/sh

rm -rf ./conf/keys
mkdir -p ./conf/keys
docker run --name ca-setup --rm -v $PWD/conf/keys:/root/keys-ext -it alxprd/vpn-ca build-ca
