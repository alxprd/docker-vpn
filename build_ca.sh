#!/bin/sh

docker build -t alxprd/ca     -f ./docker/Dockerfile.ca  ./docker/
docker build -t alxprd/ca-scp -f ./docker/Dockerfile.scp ./docker/
