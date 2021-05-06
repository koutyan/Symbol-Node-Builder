#!/bin/bash

username=`whoami`

if [[ $username == "root" ]]; then
  echo "Run as non-root user."
  exit 1
fi

# Install Ansible.
sudo apt update
sudo apt install -y software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible sshpass

echo;
echo "Setup done."
echo;
echo "Then, enter this command to build Symbol node."
echo -e "\n"
echo "ansible-playbook playbook.yml -vvv"
echo -e "\n"