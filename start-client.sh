#!/bin/sh

echo_template() {
	echo "Help: ./start-client.sh -h"
	echo "Use:  ./start-client.sh -c <client_config_path> ..."
}

# Default param values:
client_package_path=''

arr=($1 $2)
while getopts 'hc:' optp "${arr[@]}"
do
  case $optp in
    h) echo_template; exit 0 ;;
		c) client_package_path=$OPTARG ;;
  esac
done

shift $(($OPTIND-1))

if [ -z "${client_package_path}" ]; then
	echo "Asign a valid client package path!"
  echo_template
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
	-it alxprd/vpn:client start-client "$@"
