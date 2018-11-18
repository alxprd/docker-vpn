#!/bin/sh

docker run --name "graphite" --rm \
  --net vpn-host-net \
  -p 80:80 \
  -p 2003-2004:2003-2004 \
  -p 2023-2024:2023-2024 \
  -p 8125:8125/udp \
  -p 8126:8126 \
  -v $PWD/config/graphite:/opt/graphite/conf \
  -v $PWD/data/graphite:/opt/graphite/storage \
  -v $PWD/config/statsd:/opt/statsd \
  -it graphiteapp/graphite-statsd

# Default user root|root
