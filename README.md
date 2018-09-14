# Docker VPN

Implementation of a [VPN network](https://en.wikipedia.org/wiki/Virtual_private_network) with a [Certificate Authority](https://en.wikipedia.org/wiki/Certificate_authority) using [Docker](https://www.docker.com/) and [OpenVPN](https://github.com/OpenVPN/openvpn).

### Features:

- OpenVPN network (many-clients <-> one-server) configured with [PKI CA](https://en.wikipedia.org/wiki/Public_key_infrastructure) using [EasyRSA](https://github.com/OpenVPN/easy-rsa).
- The Certificate Authority keys are contained in a single [TAR](https://www.computerhope.com/unix/utar.htm) file. It's possible to have different CA at the same time.
- Lightweight server and client containers based on [Alpine Linux](https://hub.docker.com/_/alpine/).
- The server and client configuration files are contained in a single [ZIP](https://www.computerhope.com/unix/zip.htm) file.
- It's possible to create a single configuration file for each client in `ovpn` format that contains all the necessary certificates and keys.
- All the internet traffic is tunneled through the VPN.
- Clients inside the same VPN network can connect with each other.

### Repositories:

- [GitHub](https://github.com/alxprd/docker-vpn)
- [Docker Hub](https://hub.docker.com/r/alxprd/vpn/)

### How to use:

##### 1. Install Docker:

- [Docker Desktop](https://www.docker.com/products/docker-desktop) for Mac and Windows.
- [Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)

##### 2. Build Docker Images:
```
./build.sh
```
Creates three images:
- `alxprd/vpn:ca` Handles the Certificate Authority.
- `alxprd/vpn:server` Runs a OpenVPN server.
- `alxprd/vpn:client` Runs a OpenVPN client.

##### 3. Create Certificate Authority:
```
./setup-ca.sh <ca_name>
# Example: ./setup-ca.sh ca
```
Creates a package (`data/ca_name.tar`) with all the keys and files of the CA.

##### 4. Create Server:
```
./setup-server.sh <ca_package_path> <server_name>
# Example: ./setup-server.sh ./data/ca.tar server1
```
Creates a package (`data/server_name.zip`) with all the OpenVPN server configuration files. Creates a new certificate/key pair named `server_name` inside the CA package if it doesn't exist.

*Optional:*
```
./copy-server-to-remote.sh <server_config_path> <user@host:path>
# Example: ./copy-server-to-remote.sh ./data/server1.zip alxprd@127.0.0.1:/home/alxprd
```
Copy an existing server config package to a remote host using [scp](https://www.computerhope.com/unix/scp.htm).

##### 5. Create Client:
```
./setup-client.sh <ca_package_path> <client_name> <server_name> <server_address> [-compact]
# Example 1: ./setup-client.sh ./data/ca.tar client1 server1 172.17.0.2
# Example 2: ./setup-client.sh ./data/ca.tar client2 server1 172.17.0.2 -compact
```
Creates a package (`data/client_name.zip`) with all the OpenVPN client configuration files to connect to `server_name`. Creates a new certificate/key pair named `client_name` inside the CA package if it doesn't exist. The server `server_name` must be created in advance in the CA package to be able to get the shared secret (`ta.key`). `server_address` is the address of the remote host where the server is running. If the flag `-compact` is used only one file (`data/client_name.ovpn`) will be created containing all the information needed to connect to the server.

##### 6. Start Server:
```
./start-server.sh <server_config_path>
# Example: ./start-server.sh ./data/server1.zip
```
Runs the server using the configuration from `server_config_path`.

To check the logs from the Docker container of the VPN server:
```
docker logs <vpn-server-container-name>
# Example: docker logs vpn-server-server1
```

To start a shell in the Docker container of the VPN server:
```
docker exec -it <vpn-server-container-name> sh
# Example: docker exec -it vpn-server-server1 sh
```

##### 7. Start Client:
```
./start-client.sh <client_config_path>
# Example 1: ./start-client.sh ./data/client1.zip
# Example 2: ./start-client.sh ./data/client2.ovpn
```
Runs the server using the configuration from `client_config_path`.

To check the logs from the Docker container of the VPN client:
```
docker logs <vpn-client-container-name>
# Example: docker logs vpn-client-client1
```

To start a shell in the Docker container of the VPN client:
```
docker exec -it <vpn-client-container-name> sh
# Example: docker exec -it vpn-client-client1 sh
```

### Other useful commands:

Check public IP:
```
curl ipinfo.io/ip
```

### OpenVPN configuration templates:

- [Server](https://raw.githubusercontent.com/OpenVPN/openvpn/master/sample/sample-config-files/server.conf)
- [Client](https://raw.githubusercontent.com/OpenVPN/openvpn/master/sample/sample-config-files/client.conf)

### Sources:

- [Setup a hardened OpenVPN server](https://www.linode.com/docs/networking/vpn/set-up-a-hardened-openvpn-server/).
- [Tunnel your internet traffic through an OpenVPN server](https://www.linode.com/docs/networking/vpn/tunnel-your-internet-traffic-through-an-openvpn-server/).
- [How to run OpenVPN in a Docker container on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-run-openvpn-in-a-docker-container-on-ubuntu-14-04/).
- [How to set-up an OpenVPN server on Debian 9](https://www.digitalocean.com/community/tutorials/how-to-set-up-an-openvpn-server-on-debian-9)
- [OpenVPN HOWTO](https://openvpn.net/howto).