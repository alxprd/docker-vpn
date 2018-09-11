#!/bin/sh

server_name=$1

if [ -z "${server_name}" ]; then
        echo "Asign a valid server name!"
        exit 0
fi

if [ ! -d "$PWD/conf/servers/$server_name" ]; then
        echo "Server '$server_name' doesn't exist!"
        exit 0
fi

export_dir=$PWD/exported/servers/${server_name}
export_file=$export_dir/ta.key

mkdir -p $export_dir
rm -f $export_file
echo "$(sudo cat $PWD/conf/servers/$server_name/ta.key)" >> $export_file
#cp --no-preserve=mode,ownership $PWD/conf/servers/$server_name/ta.key $export_dir/ta.key
#chown -R $USER:$USER $export_dir/
