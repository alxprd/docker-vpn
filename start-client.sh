#!/bin/sh

# Default param values:
client_package_path=''
force_remote=''

while getopts 'hc:r:' optp
do
  case $optp in
		c) client_package_path=$OPTARG ;;
		r) force_remote="-r $OPTARG" ;;
  esac
done

if [ -z "${client_package_path}" ]; then
	echo "Asign a valid client package path!"
	exit 0
fi

# If it's a relative path adds $PWD to make it work with Docker
case $client_package_path in
	/*) ;;
	*) client_package_path=$PWD/$client_package_path ;;
esac

if [ ! -f "$client_package_path" ]; then
	echo "Client package '$client_package_path' doesn't exist!"
	exit 0
fi

client_name=$(basename "${client_package_path%.*}")
filename=$(basename "$client_package_path")
ext="${filename##*.}"

docker run --name "vpn-client-${client_name}" --rm --privileged \
	-v $client_package_path:/root/client.$ext:ro \
	-d alxprd/vpn:client start-client $force_remote
