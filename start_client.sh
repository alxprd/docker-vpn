#!/bin/bash

client_name=$1

if [ -z "${client_name}" ]; then
        echo "Asign a valid client name!"
        exit 0
fi

if [ ! -d "$PWD/conf/clients/$client_name" ]; then
        echo "Client '$client_name' doesn't exist!"
        exit 0
fi

docker run --name "vpn-client-${client_name}" --rm --privileged \
	-v $PWD/conf/clients/$client_name:/etc/openvpn/client:ro \
	-d alxprd/vpn-client
