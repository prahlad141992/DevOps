#!/bin/bash
#
apt-get update
apt install apache2 wget unzip -y
echo "Hello Prahlad, This is your Terraform loadbalancer code" > /var/www/html/index.html
systemctl restart apache2
systemctl enable apache2
