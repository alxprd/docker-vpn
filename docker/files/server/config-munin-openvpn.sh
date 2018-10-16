#!/bin/sh

# Install the plugin with:

#wget 'https://raw.github.com/jforman/munin-openvpn/master/openvpn_usercount' \
#  --no-check-certificate --output-document='/usr/lib/munin/plugins/openvpn_usercount'
#chmod +x '/usr/lib/munin/plugins/openvpn_usercount'

#wget 'https://raw.github.com/jforman/munin-openvpn/master/openvpn_usertransfer' \
#  --no-check-certificate --output-document='/usr/lib/munin/plugins/openvpn_usertransfer'
#chmod +x '/usr/lib/munin/plugins/openvpn_usertransfer'

wget 'https://raw.githubusercontent.com/munin-monitoring/contrib/master/plugins/vpn/openvpn_as_mtime' \
  --no-check-certificate --output-document='/usr/lib/munin/plugins/openvpn_as_mtime'
chmod +x '/usr/lib/munin/plugins/openvpn_as_mtime'

wget 'https://raw.githubusercontent.com/munin-monitoring/contrib/master/plugins/vpn/openvpn_as_traffic' \
  --no-check-certificate --output-document='/usr/lib/munin/plugins/openvpn_as_traffic'
chmod +x '/usr/lib/munin/plugins/openvpn_as_traffic'

wget 'https://raw.githubusercontent.com/munin-monitoring/contrib/master/plugins/vpn/openvpn_as_ttime' \
  --no-check-certificate --output-document='/usr/lib/munin/plugins/openvpn_as_ttime'
chmod +x '/usr/lib/munin/plugins/openvpn_as_ttime'

wget 'https://raw.githubusercontent.com/munin-monitoring/contrib/master/plugins/vpn/openvpn_as_users' \
  --no-check-certificate --output-document='/usr/lib/munin/plugins/openvpn_as_users'
chmod +x '/usr/lib/munin/plugins/openvpn_as_users'

wget 'https://raw.githubusercontent.com/munin-monitoring/contrib/master/plugins/vpn/openvpn_multi' \
  --no-check-certificate --output-document='/usr/lib/munin/plugins/openvpn_multi'
chmod +x '/usr/lib/munin/plugins/openvpn_multi'

#wget 'https://raw.github.com/jforman/munin-openvpn/master/openvpn_usercount' -O '/etc/munin/plugins/openvpn_usercount'
#chmod +x '/etc/munin/plugins/openvpn_usercount'

#wget 'https://raw.github.com/jforman/munin-openvpn/master/openvpn_usertransfer' -O '/etc/munin/plugins/openvpn_usertransfer'
#chmod +x '/etc/munin/plugins/openvpn_usertransfer'

# Enable it with:

#ln -s '/usr/lib/munin/plugins/openvpn_usertransfer' '/etc/munin/plugins/openvpn_usertransfer'
#ln -s '/usr/lib/munin/plugins/openvpn_usercount' '/etc/munin/plugins/openvpn_usercount'

ln -s '/usr/lib/munin/plugins/openvpn_as_mtime' '/etc/munin/plugins/openvpn_as_mtime'
ln -s '/usr/lib/munin/plugins/openvpn_as_traffic' '/etc/munin/plugins/openvpn_as_traffic'
ln -s '/usr/lib/munin/plugins/openvpn_as_ttime' '/etc/munin/plugins/openvpn_as_ttime'
ln -s '/usr/lib/munin/plugins/openvpn_as_users' '/etc/munin/plugins/openvpn_as_users'
ln -s '/usr/lib/munin/plugins/openvpn_multi' '/etc/munin/plugins/openvpn_multi'

# You can graph multiple OpenVPN networks by appending the network name to plugin alias (here for 'network.vpn'):

#ln -s '/usr/share/munin/plugins/openvpn_usertransfer' '/etc/munin/plugins/openvpn_usertransfer_network.vpn'
#ln -s '/usr/share/munin/plugins/openvpn_usercount' '/etc/munin/plugins/openvpn_usercount_network.vpn'

#/etc/munin/munin-node.conf
#Add these lines (adapted to your need) to munin-node configuration:

#echo "[openvpn_usertransfer]" >> /etc/munin/munin-node.conf
#echo "user root" >> /etc/munin/munin-node.conf
#echo "env.statusfile /var/log/openvpn-status.log" >> /etc/munin/munin-node.conf

#echo "[openvpn_usercount]" >> /etc/munin/munin-node.conf
#echo "user root" >> /etc/munin/munin-node.conf
#echo "env.statusfile /var/log/openvpn-status.log" >> /etc/munin/munin-node.conf

# paranoia true # only root plugins
