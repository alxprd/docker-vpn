#!/bin/bash

docker run --name vpn-server --rm --privileged -p 1194:1194/udp -v $PWD/conf:/conf -d alxprd/vpn start_server
