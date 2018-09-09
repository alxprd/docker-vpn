# docker-vpn


**Installation:**

Build Images:
```
./build_ca.sh
./build_vpn.sh
```

Create Certificate Authority:
```
./setup_ca.sh
```

Create Server:
```
./setup_ca_server.sh <server_name>
./setup_vpn_server.sh <server_name>
```

Create Client:
```
./setup_ca_client.sh <client_name>
./setup_vpn_client.sh <client_name> <server_ip>
```
Copy 'ta.key' from the server configuration dir (`conf/servers/<server_name>`) to the client configuration dir (`conf/clients/<client_name>`).

Start Server:
```
./start_server.sh <server_name>
```

Start Client:
```
./start_client.sh <client_name>
```


**Copy _secret_ from local host to remote server:**

scp _source destination_

`scp <local-repo-path>/conf/servers/<server_name>/ta.key <remote-user>@<remote-ip>:<remote-repo-path>/conf/servers/<remote_server_name>/`


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
