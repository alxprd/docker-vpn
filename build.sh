#!/bin/sh

docker build -t alxprd/vpn-ca     -f ./docker/Dockerfile.ca          ./docker/
#docker build -t alxprd/vpn-ca-scp -f ./docker/Dockerfile.scp        ./docker/
docker build -t alxprd/vpn-server -f ./docker/Dockerfile_ovpn.server ./docker/
docker build -t alxprd/vpn-client -f ./docker/Dockerfile_ovpn.client ./docker/
