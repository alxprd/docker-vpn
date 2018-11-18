#!/bin/sh

mkdir -p $PWD/config/collectd

if [ ! -f "$PWD/config/collectd/collectd.conf" ]; then
  echo "Create default 'collectd.conf' file"
  docker run --rm alxprd/collectd "cat /etc/collectd/collectd.conf" > $PWD/config/collectd/collectd.conf
fi

if [ ! -f "$PWD/config/collectd/types.db" ]; then
  echo "Create default 'types.db' file"
  docker run --rm alxprd/collectd "cat /usr/share/collectd/types.db" > $PWD/config/collectd/types.db
fi

docker run --name "collectd-test" --rm \
  -v $PWD/config/collectd/collectd.conf:/etc/collectd/collectd.conf:ro \
	-it alxprd/collectd
