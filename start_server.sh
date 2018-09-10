#!/bin/bash

server_name=$1

if [ -z "${server_name}" ]; then
        echo "Asign a valid server name!"
        exit 0
fi

if [ ! -d "$PWD/conf/servers/$server_name" ]; then
	echo "Server '$server_name' doesn't exist!"
	exit 0
fi

docker run --name "vpn-server-${server_name}" --rm --privileged -p 1194:1194/udp \
	-v $PWD/conf/servers/$server_name:/etc/openvpn/server:ro \
	-v $PWD/conf/server-ca2.conf:/etc/openvpn/server.conf:ro \
	-d alxprd/vpn-server
