# docker-vpn


**Copy _static.key_ from local host to remote server:**

scp _source destination_

`scp <local-repo-path>/conf/static.key <remote-user>@<remote-ip>:<remote-repo-path>/conf/`


**Check logs from VPN server:**

`docker logs vpn-server`


**Check logs from VPN client:**

`docker logs vpn-client`


**Open a new bash shell in the running VPN server container:**

`docker exec -it vpn-server bash`


**Open a new bash shell in the running VPN client container:**

`docker exec -it vpn-client bash`


**Check public IP:**

`curl ipinfo.io/ip`
