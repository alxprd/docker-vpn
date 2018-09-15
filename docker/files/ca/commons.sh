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
	echo "Generate Diffie-Hellman parameter (DH param)"
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
	echo "Export DH param (dhp.pem)"
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
	echo "Set remote server address to '$server_address' in client config"
	perl -i -pe "s/remote <server address>/remote $server_address/g;" $export_dir/client.ovpn
}

set_client_keys() {
	echo "Set CA files paths in client config"
	local entry_ca='ca /etc/openvpn/client/ca.crt'
	local entry_cert='cert /etc/openvpn/client/client.crt'
	local entry_key='key /etc/openvpn/client/client.key'
	local entry_ta='tls-auth /etc/openvpn/client/ta.key'
	perl -i -pe "s~ca <ca.crt>~$entry_ca~g" $export_dir/client.ovpn
	perl -i -pe "s~cert <client.crt>~$entry_cert~g" $export_dir/client.ovpn
	perl -i -pe "s~key <client.key>~$entry_key~g" $export_dir/client.ovpn
	perl -i -pe "s~tls-auth <ta.key>~$entry_tag~g" $export_dir/client.ovpn
}

set_client_keys_compact() {
	echo "Set CA files content inside client config (COMPACT!)"
	content_ca=$(cat $export_dir/ca.crt)
	content_crt=$(cat $export_dir/${type_keys}.crt)
	content_key=$(cat $export_dir/${type_keys}.key)
	content_ta=$(cat $export_dir/ta.key)
	perl -i -pe "s~ca <ca.crt>~<ca>\n$content_ca\n</ca>~g" $export_dir/client.ovpn
	perl -i -pe "s~cert <client.crt>~<cert>\n$content_crt\n</cert>~g" $export_dir/client.ovpn
	perl -i -pe "s~key <client.key>~<key>\n$content_key\n</key>~g" $export_dir/client.ovpn
	perl -i -pe "s~tls-auth <ta.key>~<tls-auth>\n$content_ta\n</tls-auth>~g" $export_dir/client.ovpn
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

output_client_conf_compact() {
	echo "Output compact client config (${name}.ovpn)"
	rm -f $output_dir/${name}.ovpn
	cp $export_dir/client.ovpn $output_dir/${name}.ovpn
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
