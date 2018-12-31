#!/usr/bin/env bash
apt-get update
apt-get install python-pip python-dev maven apt-transport-https ca-certificates curl software-properties-common -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo "deb https://pkg.jenkins.io/debian-stable binary/" >> /etc/apt/sources.list
apt-get update && apt-get install jenkins -y
