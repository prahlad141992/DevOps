#!/usr/bin/env bash
export OS=`cat /etc/issue|awk '{print $1}'|head -n1`

if [ "${OS}" == Ubuntu ]
   then
   apt-get update
   apt-get install python-minimal wget git openjdk-8-jdk unzip -y
   sed -i -e 's/^PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
   sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/g'  /etc/ssh/sshd_config
   systemctl restart ssh
   else
   yum install python wget git java-1.8.0-openjdk -y
fi
