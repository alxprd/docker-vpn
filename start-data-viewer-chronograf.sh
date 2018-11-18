#!/bin/sh

docker run --name "vpn-data-chronograf" --rm -p 8888:8888 \
  -it chronograf:alpine --influxdb-url=http://172.17.0.2:8086
