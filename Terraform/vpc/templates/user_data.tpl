#!/bin/bash
#
apt-get update
apt install apache2 wget unzip -y
echo "Hello Prahlad, This is your terraform vpc code Demo" > /var/www/html/index.html
systemctl restart apache2
systemctl enable apache2
