#!/bin/sh

docker run --name vpn-setup --rm \
	-v $PWD/data:/root/output \
	-it alxprd/vpn:ca build-ca "$@"
