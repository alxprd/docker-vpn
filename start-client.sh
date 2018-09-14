#!/bin/sh

client_package_path=$1

if [ -z "${client_package_path}" ]; then
	echo "Asign a valid client package path!"
	exit 0
fi

# If it's a relative path adds $PWD to make it work with Docker
if [ "${client_package_path:0:1}" != "/" ]; then
	client_package_path=$PWD/$client_package_path
fi

if [ ! -f "$client_package_path" ]; then
	echo "Client package '$client_package_path' doesn't exist!"
	exit 0
fi

client_name=$(basename "${client_package_path%.*}")

docker run --name "vpn-client-${client_name}" --rm --privileged \
	-v $client_package_path:/root/client.zip:ro \
	-d alxprd/vpn:client
