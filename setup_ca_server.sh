#!/bin/sh

server_name=$1

if [ -z "${server_name}" ]; then
	echo "Asign a valid server name!"
	exit 0
fi

docker run --name ca-setup-server --rm \
	-v $PWD/conf/keys:/root/ca \
	-v $PWD/data:/root/output \
	-it alxprd/ca setup-server $server_name
