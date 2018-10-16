#!/bin/sh

echo_template() {
	echo "Help: ./start-monitor.sh -h"
#	echo "Use:  ./start-monitor.sh -c <config_monitor_path> -s <server_name> ..."
	echo "Use:  ./start-monitor.sh -c <config_monitor_path> ..."
}

# Default param values:
config_monitor_path=''
#server_name=''

#while getopts 'hc:s:' optp
while getopts 'hc:' optp
do
	case $optp in
		h) echo_template; exit 0 ;;
		c) config_monitor_path=$OPTARG ;;
#		s) server_name=$OPTARG ;;
	esac
done

shift $OPTIND

if [ -z "${config_monitor_path}" ]; then
	echo "Asign a valid monitor config file path!"
	echo_template
	exit 0
fi

#if [ -z "${server_name}" ]; then
#	echo "Asign a valid server name!"
#	echo_template
#	exit 0
#fi

# If it's a relative path adds $PWD to make it work with Docker
case $config_monitor_path in
	/*) ;;
	*) config_monitor_path=$PWD/$config_monitor_path ;;
esac

if [ ! -f "$config_monitor_path" ]; then
	echo "Monitor config file '$config_monitor_path' doesn't exist!"
	exit 0
fi

#docker run --name "vpn-monitor-${server_name}" --rm -p 80:80 \
docker run --name "vpn-monitor" --rm -p 80:80 \
	-v $config_monitor_path:/var/www/html/openvpn-monitor/openvpn-monitor.conf:ro \
	-d alxprd/vpn:monitor

# --net=container:"vpn-server-${server_name}"
#	-e OPENVPNMONITOR_DEFAULT_LOGO=logo.jpg \
