ca_dir=/root/ca
ca_keys_dir=$ca_dir/keys

ca_package_dir=/root
ca_package_name=ca.tar

secrets_dir=$ca_keys_dir/secrets
secret_name=${server_name}-ta.key

dhps_dir=$ca_keys_dir/dhps
dhp_name=${server_name}-dhp.key

output_dir=/root/output
package_name=${name}.zip

export_dir=/root/$name
