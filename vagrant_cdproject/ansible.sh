#!/usr/bin/env bash
apt-get update && apt-get install software-properties-common -y
apt-add-repository --yes --update ppa:ansible/ansible
apt-get install ansible -y
