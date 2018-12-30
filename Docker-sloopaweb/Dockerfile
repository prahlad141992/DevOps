FROM ubuntu
MAINTAINER Prahlad Singh
RUN apt-get update && apt-get install apache2 -y
ADD sloopa.tar.gz /var/www/html/
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
WORKDIR /var/www/html/
