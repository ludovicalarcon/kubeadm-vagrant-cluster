#! /bin/bash

MASTER_IP="10.0.0.10"
POD_CIDR="192.168.0.0/16"
SHARED_FOLDER="/vagrant"

echo "Init kubeadm"
sudo kubeadm init --apiserver-advertise-address=$MASTER_IP --pod-network-cidr=$POD_CIDR --node-name=$(hostname -s)

HOME=/home/vagrant/
sudo --user=vagrant mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u vagrant):$(id -g vagrant) $HOME/.kube/config

# using shared folder to keep join token and config
cp -f /etc/kubernetes/admin.conf $SHARED_FOLDER

kubeadm token create --print-join-command > $SHARED_FOLDER/scripts/join.sh
chmod +x $SHARED_FOLDER/scripts/join.sh
