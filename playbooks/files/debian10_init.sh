#!/bin/bash
# Add user in Sudo Group
usermod -aG sudo ansible

# Add Ansible Pub Key
mkdir -p  /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
cat /tmp/ansible.pub > /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh
chmod 644 /home/ansible/.ssh/authorized_keys

# Secure SSHD
sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
sed -i 's|UsePAM yes|UsePAM no|g' /etc/ssh/sshd_config
sed -i 's|[#]*PermitEmptyPasswords yes|PermitEmptyPasswords no|g' /etc/ssh/sshd_config

# Disable IPv6
echo "net.ipv6.conf.all.disable_ipv6 = 1" > /etc/sysctl.d/ipv6.conf

# Clean APT
sed -i 's/^deb cdrom:/# deb cdrom:/g' /etc/apt/sources.list