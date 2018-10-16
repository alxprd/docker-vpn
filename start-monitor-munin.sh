#!/bin/sh

docker run --name "vpn-monitor-munin" --rm -p 80:80 \
	-it alxprd/vpn:monitor-munin
