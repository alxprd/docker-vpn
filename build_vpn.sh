#!/bin/sh

#docker build -t alxprd/vpn        -f ./docker/Dockerfile_ovpn        ./docker/
docker build -t alxprd/vpn-server -f ./docker/Dockerfile_ovpn.server ./docker/
docker build -t alxprd/vpn-client -f ./docker/Dockerfile_ovpn.client ./docker/
#docker build -t alxprd/vpn-perl   -f ./docker/Dockerfile.perl        ./docker/
docker pull perl