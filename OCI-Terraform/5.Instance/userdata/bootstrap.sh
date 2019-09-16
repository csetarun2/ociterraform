#!/bin/sh
mkdir /home/opc/a
sudo yum update -y
sudo yum install httpd -y
sudo service httpd restart
echo "<h1><b>Deployed from terraform</b></h1>" >> /var/www/html/index.html
sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT
sudo service iptables save
sudo service iptables reload