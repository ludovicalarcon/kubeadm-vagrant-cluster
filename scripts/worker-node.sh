#! /bin/bash

SHARED_FOLDER="/vagrant"

# join worker node to control plane
/bin/bash $SHARED_FOLDER/scripts/join.sh

HOME=/home/vagrant/
sudo --user=vagrant mkdir -p $HOME/.kube
cp $SHARED_FOLDER/admin.conf $HOME/.kube/config
chown $(id -u vagrant):$(id -g vagrant) $HOME/.kube/config

kubectl label node $(hostname -s) node-role.kubernetes.io/worker=worker-node