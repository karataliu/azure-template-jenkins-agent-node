#!/bin/bash
set -e

DOCKER_DISK=/dev/disk/azure/scsi1/lun0
mkfs.btrfs $DOCKER_DISK
echo "$DOCKER_DISK /var/lib/docker btrfs rw,relatime 0 2" >> /etc/fstab
mount -a

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt update
DEBIAN_FRONTEND=noninteractive apt -y --no-install-recommends install \
    openjdk-9-jre build-essential docker-ce=17.06.2~ce-0~ubuntu
usermod -aG docker jenkins
ls /dev/sd*
