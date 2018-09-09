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

docker run --name vpn-server-setup --rm -v $PWD/conf/servers/$server_name:/etc/openvpn/server alxprd/vpn generate_secret
docker run --name vpn-server-setup --rm -v $PWD/conf/servers/$server_name:/etc/openvpn/server alxprd/vpn generate_dhparam
