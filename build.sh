#!/bin/sh

docker build -t alxprd/vpn:ca      -f ./docker/Dockerfile_ovpn.ca      ./docker/
docker build -t alxprd/vpn:server  -f ./docker/Dockerfile_ovpn.server  ./docker/
docker build -t alxprd/vpn:monitor -f ./docker/Dockerfile_ovpn.monitor ./docker/
docker build -t alxprd/vpn:client  -f ./docker/Dockerfile_ovpn.client  ./docker/

docker build -t alxprd/vpn:monitor-grafana -f ./docker/Dockerfile_ovpn.monitor-grafana \
  --build-arg "GRAFANA_VERSION=latest" \
  --build-arg "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource" \
  ./docker/
