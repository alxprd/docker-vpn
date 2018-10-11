#!/bin/sh

echo_template() {
	echo "Help: ./start-monitor.sh -h"
	echo "Use:  ./start-monitor.sh -s <server_name> ..."
}

# Default param values:
server_name=''

while getopts 'hs:' optp "$1$2"
do
	case $optp in
		h) echo_template; exit 0 ;;
		s) server_name=$OPTARG ;;
	esac
done

shift $OPTIND

if [ -z "${server_name}" ]; then
	echo "Asign a valid server name!"
	echo_template
	exit 0
fi

docker run --name "vpn-monitor-${server_name}" --rm --net=container:"vpn-server-${server_name}" \
	-e OPENVPNMONITOR_DEFAULT_DATETIMEFORMAT="%%d/%%m/%%Y" \
	-e OPENVPNMONITOR_DEFAULT_LATITUDE=-37 \
	-e OPENVPNMONITOR_DEFAULT_LONGITUDE=144 \
	-e OPENVPNMONITOR_DEFAULT_MAPS=True \
	-e OPENVPNMONITOR_DEFAULT_SITE=Test \
	-e OPENVPNMONITOR_SITES_0_ALIAS=UDP-alias \
	-e OPENVPNMONITOR_SITES_0_HOST=127.0.0.1 \
	-e OPENVPNMONITOR_SITES_0_NAME=UDP-name \
	-e OPENVPNMONITOR_SITES_0_PORT=5555 \
	-e OPENVPNMONITOR_SITES_1_ALIAS=TCP-alias \
	-e OPENVPNMONITOR_SITES_1_HOST=127.0.0.1 \
	-e OPENVPNMONITOR_SITES_1_NAME=TCP-name \
	-e OPENVPNMONITOR_SITES_1_PORT=5555 \
	-d alxprd/vpn:monitor

#	-e OPENVPNMONITOR_DEFAULT_LOGO=logo.jpg \
