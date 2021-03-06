#!/bin/bash
dominio="internal"
hostname "`hostname`.$dominio"
echo `hostname` > /etc/hostname
echo "`ifconfig eth0 | grep broadcast | awk '{print $2}'` `hostname`" >> /etc/hosts

setenforce permissive
sed -i.bak "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux/config
sed -i.bak "s/#UseDNS yes/UseDNS no/g" /etc/ssh/sshd_config

echo -e "\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfUkC+X0K85f5XifA8COA9wnoSOL/VJZrz6sK72REjlnYgkGF7/ggee7AryGFcHdewlDTUxrmLJ/0EkYjBtP6xUhySRr+Z2TDsgyUFcqmKhsK91gVoyOfcKw/TPKRV1z4Sp9Xe3ZU6fLl7IG1UyDxYXf/RCyMHWx44Le2YsNxbQPqwAW/5ihskrMkCt3iZMMy3SFDYnq02ua9t/5SYfV0ulLXbWjI3Ry9oJk7jwnbd65YfH/OXHDiBVGF8e6e043vx0+jy+k2DK+DGXeFtYlLBzfH5ey3IbCHumujSycIBRvw9SyhInwthcVpCBfFp6eTd0AgzgrRt41RzBZ9RjD0p nariga@active-book
\nssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdQMpmcqaT02NSs4BpFkiSW+COvSzDPOTaeUL5rZtysGL2X7lLxqPPI1EUhXHvlkM+VZeFNr036wecAGH2hEE6A1L1y/gFsCOgjmshXPZ7+PixkzR4996o9qSks0agNNGUduzsMqEspSffgJM37Ylrh2sXVIzcqq8g0cU/Xe231TgtNWawikR+DyLwuow5FOlrikFt+qnMnhFMgmg6HFom1TtFZX1lLLa8sn+5nYlQrn
tcOYK2GqbPUtlqNYfzLtEvv39zQWrq/LJIjp1z43O0Z3/RZFQsMOVMGux1+L2TkxCc5elSfJPXWke9p/j02FVpT/Nrv9x97Uq+J68OQqtP nariga@vostro.home.jab" \
>> /home/administrator/.ssh/authorized_keys

systemctl restart sshd
cat /etc/cloud/cloud.cfg | grep -v host > /tmp/cloud.cfg ; mv /tmp/cloud.cfg /etc/cloud/
echo "deb http://deb.theforeman.org/ jessie 1.11" > /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins 1.11" >> /etc/apt/sources.list.d/foreman.list
wget -q http://deb.theforeman.org/pubkey.gpg -O- | apt-key add -
apt-get update && apt-get -y install foreman-installer
