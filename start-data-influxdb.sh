#!/bin/sh

mkdir -p $PWD/config/influxdb

if [ ! -f "$PWD/config/influxdb/influxdb.conf" ]; then
  echo "Create default 'influxdb.conf' file"
  docker run --rm influxdb:alpine influxd config > $PWD/config/influxdb/influxdb.conf
fi

docker run --name "vpn-data-influxdb" --rm \
  -p 8086:8086 \
  -p 25826:25826/udp \
  -v $PWD/data/influxdb/db:/var/lib/influxdb \
  -v $PWD/config/influxdb/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
  -v $PWD/config/collectd/types.db:/usr/share/collectd/types.db:ro \
  -it influxdb:alpine

#  -e INFLUXDB_DB=collectd \
