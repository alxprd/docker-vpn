#!/bin/sh

mkdir -p $PWD/data/grafana # creates a folder for your data
ID=$(id -u) # saves your user id in the ID variable

# starts grafana with your user id and using the data folder
#docker run --name "vpn-monitor-grafana" --rm -p 3000:3000 \
#  -d alxprd/vpn:monitor-grafana

docker run --name "vpn-monitor-grafana" --user $ID --rm -p 3000:3000 \
  -e "GF_SECURITY_ADMIN_PASSWORD=hunter2" \
  -v "$PWD/data/grafana:/var/lib/grafana" \
  -it alxprd/vpn:monitor-grafana
