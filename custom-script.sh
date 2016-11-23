#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:
# yum install -y curl wget git tmux firefox xvfb

echo "Installing Kuberbetes with Docker"
#Installing Kuberbetes with Docker
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update -y
apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni
touch /master.sh
cat <<EOF > /master.sh
#!/bin/bash
touch adm
touch minion.sh
echo '#!/bin/bash' >> minion.sh
kubeadm init >> adm
tail adm -n 1 >> minion.sh
echo "Master configuration is done!"
sleep 3
clear
echo "Run the following command on all the node which you need to configure it as an minion"
cat minion.sh
sleep 5
EOF

apt-get install -y emacs git tree bzip2 ntp telnet inetutils-traceroute nmap

mkdir -p /local_packages

cd /local_packages

  sudo apt-get --print-uris --yes -d --reinstall install apache2 mysql-server php-mysql php libapache2-mod-php php-mcrypt php-cli $(apt-cache depends apache2 mysql-server php-mysql php libapache2-mod-php php-mcrypt php-cli | grep "  Depends:" |  sed 's/  Depends://' | sed ':a;N;$!ba;s/\n//g') | grep ^\' | cut -d\' -f2 >downloads.list

wget --input-file downloads.list
