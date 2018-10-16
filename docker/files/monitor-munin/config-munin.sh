#!/bin/sh

# Source: https://wiki.debian.org/Munin/ApacheConfiguration
# Apache2 access logs: nano /var/log/apache2/access.log
# Apache2 errors logs: nano /var/log/apache2/error.log


#sed -i -e "s~#graph_strategy cron~graph_strategy cgi~g" /etc/munin/munin.conf
#sed -i -e "s~#html_strategy cron~html_strategy cgi~g" /etc/munin/munin.conf


#a2enconf munin

sed -i -e "s~#dbdir\s*/var/lib/munin~dbdir /var/lib/munin~g" /etc/munin/munin.conf
#sed -i -e "s~#htmldir\s*/var/cache/munin/www~htmldir /var/www/munin~g" /etc/munin/munin.conf
sed -i -e "s~#htmldir\s*/var/cache/munin/www~htmldir /var/cache/munin/www~g" /etc/munin/munin.conf
sed -i -e "s~#logdir\s*/var/log/munin~logdir /var/log/munin~g" /etc/munin/munin.conf
sed -i -e "s~#rundir\s*/var/run/munin~rundir /var/run/munin~g" /etc/munin/munin.conf
sed -i -e "s~#tmpldir\s*/etc/munin/templates~tmpldir /etc/munin/templates~g" /etc/munin/munin.conf

#mkdir -p /var/www/munin
#chown munin:munin /var/www/munin

sed -i -e "s~\[localhost.localdomain\]~\[MuninMaster\]~g" /etc/munin/munin.conf

#sed -i -e "s~Alias /munin /var/cache/munin/www~Alias /munin /var/www/munin~g" /etc/munin/apache.conf

#sed -i -e "s~<Directory /var/cache/munin/www>~<Directory /var/www/munin>~g" /etc/munin/apache.conf

#Get line numbers:

#echo "start $(grep -n '<Directory .*>' /etc/munin/apache.conf)"
#echo "end   $(grep -n '</Directory>' /etc/munin/apache.conf)"

#echo "s $(sed -n '/<Directory .*>/=' /etc/munin/apache.conf)"
#echo "e $(sed -n '/<\/Directory>/=' /etc/munin/apache.conf)"

#sed -i -e '/^<Directory .*>$/,/^<\/Directory>$/{ s~Order allow,deny~# Order allow,deny~g; }' /etc/munin/apache.conf
#sed -i -e '/^<Directory .*>$/,/^<\/Directory>$/{ s~Allow from localhost 127.0.0.0/8 ::1~# Allow from localhost 127.0.0.0/8 ::1~g; }' /etc/munin/apache.conf
#sed -i -e '/^<Directory .*>$/,/^<\/Directory>$/{ s~Options None~# Options None\n\n\tRequire all granted\n\tOptions FollowSymLinks SymLinksIfOwnerMatch~g; }' /etc/munin/apache.conf

# \n\n\tDirectoryIndex index.html

#sed -i -e '/^<Location \/munin-cgi\/munin-cgi-graph>$/,/^<\/Location>$/{ s~# require valid-user~# require valid-user\n\n\tRequire all granted\n\tOptions FollowSymLinks SymLinksIfOwnerMatch\n~g; }' /etc/munin/apache.conf
#sed -i -e '/^<Location \/munin-cgi\/munin-cgi-html>$/,/^<\/Location>$/{ s~# require valid-user~# require valid-user\n\n\tRequire all granted\n\tOptions FollowSymLinks SymLinksIfOwnerMatch\n~g; }' /etc/munin/apache.conf

#service apache2 restart
#service munin-node restart

sed -i -e '/^<Directory .*>$/,/^<\/Directory>$/{ s~Require local~Require all granted\n\tOptions FollowSymLinks SymLinksIfOwnerMatch~g; }' /etc/munin/apache24.conf
sed -i -e '/^<Directory .*>$/,/^<\/Directory>$/{ s~Options None~# Options None~g; }' /etc/munin/apache24.conf

sed -i -e '/^<Location \/munin-cgi\/munin-cgi-graph>$/,/^<\/Location>$/{ s~Require local~Require all granted\n\tOptions FollowSymLinks SymLinksIfOwnerMatch~g; }' /etc/munin/apache24.conf
