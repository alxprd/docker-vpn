#!/bin/sh

ca_package_path=$1
shift # After shift, what used to be $1 has been removed from the list

if [ -z "${ca_package_path}" ]; then
	echo "Asign a valid CA package path!"
	exit 0
fi

# If it's a relative path adds $PWD to make it work with Docker
if [ "${ca_package_path:0:1}" != "/" ]; then
	ca_package_path=$PWD/$ca_package_path
fi

if [ ! -f "$ca_package_path" ]; then
	echo "CA keys package '$ca_package_path' doesn't exist!"
	exit 0
fi

ca_name=$(basename "${ca_package_path}")
echo "Using CA keys package '$ca_name'"

docker run --name vpn-setup-server --rm \
	-v $ca_package_path:/root/ca.tar \
	-v $PWD/data:/root/output \
	-it alxprd/vpn:ca setup-server "$@"

