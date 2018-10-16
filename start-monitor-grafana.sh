#!/bin/sh

docker run --name "vpn-monitor-grafana" --rm -p 3000:3000 \
  -it grafana/grafana
