#!/bin/sh

echo_template() {
	echo "Help: ./start-server.sh -h"
	echo "Use:  ./start-server.sh -c <server_config_path> ..."
}

# Default param values:
server_package_path=''
management=''

while getopts 'hc:m:' optp
do
	case $optp in
		h) echo_template; exit 0 ;;
		c) server_package_path=$OPTARG ;;
		m) management=$OPTARG ;;
	esac
done

shift 2

if [ -z "${server_package_path}" ]; then
	echo "Asign a valid server package path!"
	echo_template
	exit 0
fi

# If it's a relative path adds $PWD to make it work with Docker
case $server_package_path in
	/*) ;;
	*) server_package_path=$PWD/$server_package_path ;;
esac

if [ ! -f "$server_package_path" ]; then
	echo "Server package '$server_package_path' doesn't exist!"
	exit 0
fi

if [ ! -z "${management}" ]; then
	port=$(echo ${management} | cut -d':' -f2)
	management_port="-p ${port}:${port}"
else
	management_port=''
fi

server_name=$(basename "${server_package_path%.*}")

docker run --name "vpn-server-${server_name}" --rm --privileged -p 1194:1194/udp ${management_port} \
  --net vpn-host-net \
	-v $server_package_path:/root/server.zip:ro \
	-v $PWD/config/collectd/collectd-vpn.conf:/etc/collectd/collectd.conf:ro \
	-d alxprd/vpn:server start-server "$@"
