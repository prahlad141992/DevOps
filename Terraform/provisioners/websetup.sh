sudo yum update -y
sudo yum install httpd wget unzip -y
echo "Hello web server test" >> /var/www/html/index.html
sudo service httpd restart
sudo chkconfig httpd on
