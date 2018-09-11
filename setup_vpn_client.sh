#!/bin/sh

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

rm -f $PWD/conf/clients/$client_name/client.ovpn
cp $PWD/conf/client-template.ovpn $PWD/conf/clients/$client_name/client.ovpn

docker run --name vpn-client-setup --rm \
	-v $PWD/conf/clients/$client_name:/root/client \
	perl perl -i -pe "s/remote <server IP address>/remote $server_ip/g;" /root/client/client.ovpn

echo "File client.ovpn created with server ip '$server_ip'."
