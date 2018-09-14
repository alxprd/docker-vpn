build_ca() {
	echo "Create Certificate Authority (CA)"
	cd $ca_dir
	. ./vars
	./clean-all
	./build-ca
}

create_server_keys() {
	echo "Create '$name' crt/key in CA"
	cd $ca_dir
	. ./vars
	./build-key-server $name
}

create_client_keys() {
	echo "Create '$name' crt/key in CA"
	cd $ca_dir
	. ./vars
	./build-key $name
	# Anyone with access to client1.key will be able to access your VPN. To better protect
	# against this scenario, you can issue ./build-key-pass $name instead to build a
	# client key which is encrypted with a passphrase.
}

# ----------------------

create_ca_package() {
	echo "Create CA keys package ($ca_package_name)"
	rm -f $output_dir/$ca_package_name
	cd $ca_keys_dir
	tar -cf $output_dir/$ca_package_name *
	#zip -r $output_dir/$ca_package_name *
	# If you have sensitive information that you want to store in a zip
	# file, use the -e command to encrypt it. You are asked to enter a
	# password and to repeat the password:
	#zip -r $output_dir/$ca_package_name * -e
}

import_ca_package() {
	echo "Import CA keys package"
	mkdir -p $ca_keys_dir
	tar -xf $ca_package_dir/$ca_package_name -C $ca_keys_dir
	#unzip $ca_package_dir/$ca_package_name -d $ca_keys_dir
}

update_ca_package() {
	echo "Update CA keys package"
	cd $ca_keys_dir
	tar -uf $ca_package_dir/$ca_package_name *
	#zip -r $ca_package_dir/$ca_package_name *
}

# ----------------------

generate_server_secret() {
	echo "Generate HMAC signature (server secret)"
	# Require a matching HMAC signature for all packets involved in
	# the TLS handshake between the server and connecting clients.
	# Packets without this signature are dropped. To generate the HMAC
	# signature file:
	rm -f $secrets_dir/$secret_name
	mkdir -p $secrets_dir
	openvpn --genkey --secret $secrets_dir/$secret_name
}

generate_dhparam() {
	echo "Generate Diffie-Hellman parameter (DHP)"
	# Generate Diffie-Hellman parameter. This is a set of randomly
	# generated data used when establishing Perfect Forward Secrecy
	# during creation of a client's session key. The default size is
	# 2048 bits, but OpenVPN's documentation recommends to use a prime
	# size equivalent to your RSA key size. Since you will be using 4096
	# bit RSA keys, create a 4096 bit DH prime. Depending on the size of
	# your Linode, this could take approximately 10 minutes to complete.
	# Note: According to OpenSSL's man page, genpkey -genparam supersedes dhparam.
	rm -f $dhps_dir/$dhp_name
	mkdir -p $dhps_dir
	openssl genpkey -genparam -algorithm DH -out $dhps_dir/$dhp_name -pkeyopt dh_paramgen_prime_len:4096
}

# ----------------------

export_keys() {
	echo "Export '$name' CA files (ca.crt, ${type_keys}.crt, ${type_keys}.key)"
	rm -f $export_dir/ca.crt
	rm -f $export_dir/${type_keys}.crt
	rm -f $export_dir/${type_keys}.key
	mkdir -p $export_dir
	cp $ca_keys_dir/ca.crt      $export_dir/ca.crt
	cp $ca_keys_dir/${name}.crt $export_dir/${type_keys}.crt
	cp $ca_keys_dir/${name}.key $export_dir/${type_keys}.key
}

export_server_secret() {
	echo "Export server secret (ta.key)"
	rm -f $export_dir/ta.key
	cp $secrets_dir/$secret_name $export_dir/ta.key
}

export_dhparam() {
	echo "Export DHP (dhp.pem)"
	rm -f $export_dir/dhp.pem
	cp $dhps_dir/$dhp_name $export_dir/dhp.pem
}

export_server_conf() {
	echo "Export server config (server.conf)"
	rm -f $export_dir/server.conf
	cp /root/files/server.conf $export_dir/server.conf
}

export_client_conf() {
	echo "Export client config (client.ovpn)"
	rm -f $export_dir/client.ovpn
	cp /root/files/client-template.ovpn $export_dir/client.ovpn
}

set_remote() {
	echo "Set remote server address to '$server_address'"
	perl -i -pe "s/remote <server address>/remote $server_address/g;" $export_dir/client.ovpn
}

# ----------------------

create_package() {
	echo "Create $type_keys config package ($package_name)"
	rm -f $output_dir/$package_name
	cd $export_dir
	zip -r $output_dir/$package_name *
	# If you have sensitive information that you want to store in a zip
	# file, use the -e command to encrypt it. You are asked to enter a
	# password and to repeat the password:
	#zip -r $output_dir/$package_name $export_dir/* -e
}

# ----------------------

# TAR:
# -f file.tar: source
# -c: create
# -x: extract
# -u: update
# -C: destination
# -v: verbose
# -z: uncompress