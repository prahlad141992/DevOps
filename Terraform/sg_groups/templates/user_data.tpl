#!/bin/bash

apt-get update
apt install apache2 wget unzip -y
echo "securoty group deployment" > /var/www/html/index.html
systemctl restart apache2
systemctl enable apache2
