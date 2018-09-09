#!/bin/bash

docker build -t alxprd/ca -f ./docker/ca/Dockerfile ./docker/ca/
docker build -t alxprd/ca-scp -f ./docker/ca/Dockerfile.scp ./docker/ca/
