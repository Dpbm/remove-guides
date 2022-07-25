#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]
then 
  echo -e "\n\e[31mPlease Run as Root!\e[1m\n"
  exit 1
fi

apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin docker docker-engine docker.io containerd runc
apt autoremove

rm -rf /var/lib/docker
rm -rf /var/lib/containerd
rm -rf /etc/apt/sources.list.d/docker.list
rm -rf /etc/apt/keyrings/docker.gpg
rm -rf /etc/docker
rm -rf /var/docker
rm -rf /run/docker
rm -rf /etc/docker*
rm -rf /var/docker*
rm -rf /var/cache/apt/archives/docker*
rm -rf /run/docker*
rm -rf /usr/lib/python3/dist-packages/sos/report/plugins/__pycache__/docker*
rm -rf /usr/lib/python3/dist-packages/sos/report/plugins/docker*
rm -rf /usr/lib/python3/dist-packages/sos/policies/runtimes/docker*
rm -rf /usr/lib/python3/dist-packages/sos/policies/runtimes/__pycache__/docker*
rm -rf /usr/share/perl5/NeedRestart/CONT/docker*


{ systemctl status docker.socket } || { echo "\n\nWasn't possible to stop docker.socket\n\n" }
{ groupdel docker } || { echo "\n\nWasn't possible to delete docker group\n\n" }

apt update
apt upgrade

for interface in $(ls /sys/class/net | grep docker)
do
    { ip link delete $interface } || { echo "\n\nWasn't possible to delete $interface interface\n\n"  }
done
