#!/bin/sh

echo_template() {
	echo "Help: ./setup-server.sh -h"
	echo "Use:  ./setup-server.sh -a <ca_package_path> ..."
}

#ca_package_path=$1
#shift # After shift, what used to be $1 has been removed from the list

# Default param values:
ca_package_path=''

while getopts 'ha:' optp "$1$2"
do
  case $optp in
		h) echo_template; exit 0 ;;
		a) ca_package_path=$OPTARG ;;
  esac
done

shift $(($OPTIND-1))

if [ -z "${ca_package_path}" ]; then
	echo "Asign a valid CA package path!"
	echo_template
	exit 0
fi

# If it's a relative path adds $PWD to make it work with Docker
case $ca_package_path in
	/*) ;;
	*) ca_package_path=$PWD/$ca_package_path ;;
esac

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
