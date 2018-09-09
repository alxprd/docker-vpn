#!/bin/bash

client_name=$1

if [ -z "${client_name}" ]; then
	echo "Asign a valid client name!"
	exit 0
fi

docker run --name ca-setup-client --rm -v $PWD/conf/keys:/root/ca/keys -v $PWD/conf/clients:/root/clients -it alxprd/ca setup_client $client_name
