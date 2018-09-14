#!/bin/sh

server_zip_path=$1

# If it's a relative path adds $PWD to make it work with Docker
if [ "${server_zip_path:0:1}" != "/" ]; then
	server_zip_path=$PWD/$server_zip_path
fi

if [ ! -f "$server_zip_path" ]; then
	echo "Server zip '$server_zip_path' doesn't exist!"
	exit 0
fi

server_name=$(basename "${server_zip_path%.*}")

docker run --name "vpn-server-${server_name}" --rm --privileged -p 1194:1194/udp \
	-v $server_zip_path:/root/server.zip:ro \
	-d alxprd/vpn-server
