#!/bin/bash

docker build -t alxprd/vpn -f ./docker/vpn/Dockerfile.openvpn ./docker/vpn/
docker build -t alxprd/vpn-client -f ./docker/vpn/Dockerfile.client.ovpn.alpine ./docker/vpn/
docker build -t alxprd/vpn-perl -f ./docker/vpn/Dockerfile.perl ./docker/vpn/
