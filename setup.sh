#!/bin/bash

username=`whoami`

if [[ $username == "root" ]]; then
  echo "Run as non-root user."
  exit 1
fi

# Install Ansible.
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible

# SSH key setup.
if [ -f ~/.ssh/id_rsa.pub ]; then
  echo "id_rsa.pub is existed."
else
  ssh-keygen -t rsa -q -N '""' -f ~/.ssh/id_rsa
fi

while read line
do
  ssh-copy-id -o StrictHostKeyChecking=no $username@$line
done < ./inventory

echo;
echo "Setup done."
echo;
echo "Then, enter this command to build Symbol node."
echo -e "\n"
echo "ansible-playbook playbook.yml"
echo -e "\n"