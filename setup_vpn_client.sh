#!/bin/bash

client_name=$1
server_ip=$2

if [ -z "${client_name}" ]; then
        echo "Asign a valid client name!"
        exit 0
fi

if [ -z "${server_ip}" ]; then
        echo "Asign a valid server ip!"
        exit 0
fi

if [ ! -d "$PWD/conf/clients/$client_name" ]; then
        echo "Client '$client_name' doesn't exist!"
        exit 0
fi

#docker run --name vpn-client-setup --rm -v $PWD/conf/clients/$client_name:/etc/openvpn/client alxprd/vpn generate_client_conf

docker run --name vpn-client-setup --rm \
	-v $PWD/conf/clients/$client_name:/root/client \
	-v $PWD/conf/client-ca2.ovpn:/root/client.ovpn:ro \
	alxprd/vpn-perl generate_client_conf $server_ip
