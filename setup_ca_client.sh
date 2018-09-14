#!/bin/sh

ca_file_path=$1
shift # After shift, what used to be $1 has been removed from the list

# If it's a relative path adds $PWD to make it work with Docker
if [ "${ca_file_path:0:1}" != "/" ]; then
	ca_file_path=$PWD/$ca_file_path
fi

if [ ! -f "$ca_file_path" ]; then
	echo "CA keys file '$ca_file_path' doesn't exist!"
	exit 0
fi

ca_name=$(basename "${ca_file_path}")
echo "Using CA keys package '$ca_name'"

docker run --name vpn-setup-client --rm \
	-v $ca_file_path:/root/ca.tar \
	-v $PWD/data:/root/output \
	-it alxprd/vpn-ca setup-client "$@"
