#!/bin/sh

docker run --name ca-setup-server --rm \
	-v $PWD/conf/keys:/root/ca/keys \
	-v $PWD/data:/root/output \
	-it alxprd/vpn-ca setup-server "$@"
