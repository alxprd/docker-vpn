#!/bin/sh

client_zip_path=$1

# If it's a relative path adds $PWD to make it work with Docker
if [ "${client_zip_path:0:1}" != "/" ]; then
	client_zip_path=$PWD/$client_zip_path
fi

if [ ! -f "$client_zip_path" ]; then
	echo "Client zip '$client_zip_path' doesn't exist!"
	exit 0
fi

client_name=$(basename "${client_zip_path%.*}")

docker run --name "vpn-client-${client_name}" --rm --privileged \
	-v $client_zip_path:/root/client.zip:ro \
	-d alxprd/vpn-client
