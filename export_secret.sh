#!/bin/bash

server_name=$1

if [ -z "${server_name}" ]; then
        echo "Asign a valid server name!"
        exit 0
fi

if [ ! -d "$PWD/conf/servers/$server_name" ]; then
        echo "Server '$server_name' doesn't exist!"
        exit 0
fi

export_dir=$PWD/conf/servers/${server_name}_export

mkdir -p $export_dir
rm -f $export_dir/ta.key
cp $PWD/conf/servers/$server_name/ta.key $export_dir/ta.key
chown -R $USER:$USER $export_dir/
