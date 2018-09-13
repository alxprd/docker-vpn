#!/bin/sh

docker run --name ca-setup-client --rm \
	-v $PWD/conf/keys:/root/ca/keys \
	-v $PWD/data:/root/output \
	-it alxprd/vpn-ca setup-client "$@"
