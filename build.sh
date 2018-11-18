#!/bin/sh

docker build -t alxprd/vpn:ca      -f ./docker/Dockerfile_ovpn.ca      ./docker/
docker build -t alxprd/vpn:server  -f ./docker/Dockerfile_ovpn.server  ./docker/
docker build -t alxprd/vpn:monitor -f ./docker/Dockerfile_ovpn.monitor ./docker/
docker build -t alxprd/vpn:client  -f ./docker/Dockerfile_ovpn.client  ./docker/

docker build -t alxprd/collectd    -f ./docker/Dockerfile_collectd     ./docker/
