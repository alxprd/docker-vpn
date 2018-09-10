# docker-vpn


**Installation:**

1. Build Images:
```
./build_ca.sh
./build_vpn.sh
```

2. Create Certificate Authority:
```
./setup_ca.sh
```

3. Create Server:
```
./setup_ca_server.sh <server_name>
./setup_vpn_server.sh <server_name>
```

4. Create Client:
```
./setup_ca_client.sh <client_name>
./setup_vpn_client.sh <client_name> <server_ip>
```
Copy 'ta.key' from the server configuration dir (`conf/servers/<server_name>`) to the client configuration dir (`conf/clients/<client_name>`).

5. Start Server:
```
./start_server.sh <server_name>
```

6. Start Client:
```
./start_client.sh <client_name>
```

**Copy configuration files between different hosts:**

To install a VPN server in a remote host there are several useful scripts.

- To copy the relevant configuration files from the Certificate Autority to the remote server you can use:
```
setup_ca_server_copy_config_to_remote.sh <server_name> <remote-user>@<remote-ip>:<remote-repo-path>/conf/servers/<remote_server_name>`
```
Probably you will get an error (_permission denied_) when copying inside `config/servers/<remote_server_name>` because it uses _scp_ and it's a folder created by a docker container with the user _root_. Use a different path and then move the file manually in the remote server (for example using SSH).

- To copy the shared secret (`ta.key`) from the remote server to the local host:
```
setup_vpn_server_copy_secret_from_remote.sh <server_name> <remote-user>@<remote-ip>:<remote-repo-path>/conf/servers/<remote_server_name>
```

- Files created inside a docker container like `ta.key` are owned by the user _root_. To be able to copy the shared secret from the server and make it readable for the clients you can use:
```
export_secret.sh <server_name>
```
This script will create a copy of `ta.key` inside `exported/servers/<server_name>`. It copies the contents of the source file and writes them in a new file owned by the current user.

**Useful docker commands:**

- Check logs from VPN server:
```
docker logs <vpn-server-container-name>
```

- Check logs from VPN client:
```
docker logs <vpn-client-container-name>
```

- Open a new bash shell in the running VPN server container:
```
docker exec -it <vpn-server-container-name> bash
```

- Open a new bash shell in the running VPN client container:
```
docker exec -it <vpn-client-container-name> bash
```

**Other useful information:**

- Check public IP:
```
curl ipinfo.io/ip
```

**Sources:**

- [Setup a hardened OpenVPN server](https://www.linode.com/docs/networking/vpn/set-up-a-hardened-openvpn-server/).
- [Tunnel your internet traffic through an OpenVPN server](https://www.linode.com/docs/networking/vpn/tunnel-your-internet-traffic-through-an-openvpn-server/).
- [How to run OpenVPN in a Docker container on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-run-openvpn-in-a-docker-container-on-ubuntu-14-04/).
