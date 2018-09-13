#!/bin/sh

server_name=$1
remote=$2

if [ -z "${server_name}" ]; then
        echo "Asign a valid server name!"
        exit 0
fi

if [ -z "${remote}" ]; then
        echo "Asign a valid remote path (<user>@<remote-ip>:<path>)!"
        exit 0
fi

if [ ! -d "$PWD/conf/servers/$server_name" ]; then
        echo "Server '$server_name' doesn't exist!"
        exit 0
fi

docker run --rm -v $PWD/conf/servers/$server_name:/root/config -it alxprd/vpn-ca-scp scp config/{ca.crt,server.crt,server.key} $remote
