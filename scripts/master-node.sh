#! /bin/bash

MASTER_IP="10.0.0.10"
POD_CIDR="192.168.0.0/16"
SHARED_FOLDER="/vagrant"

echo "Init kubeadm"
sudo kubeadm init --apiserver-advertise-address=$MASTER_IP --apiserver-cert-extra-sans=$MASTER_IP --pod-network-cidr=$POD_CIDR --node-name=$(hostname -s)

HOME=/home/vagrant/
sudo --user=vagrant mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u vagrant):$(id -g vagrant) $HOME/.kube/config

# using shared folder to keep join token and config
cp -f /etc/kubernetes/admin.conf $SHARED_FOLDER

kubeadm token create --print-join-command > $SHARED_FOLDER/scripts/join.sh
chmod +x $SHARED_FOLDER/scripts/join.sh

echo "Installing Calico"
curl https://docs.projectcalico.org/manifests/calico.yaml -O
kubectl apply -f calico.yaml

# restarting coredns after installing CNI
kubectl rollout restart deploy/coredns -n kube-system

echo "Installing Metrics Server"
curl -OL https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
sed -i "/--metric-resolution/a\        - --kubelet-insecure-tls" components.yaml
kubectl apply -f components.yaml
rm components.yaml

echo "Installing MetalLB"
kubectl create ns metallb-system
cat <<EOF | sudo tee values.yaml
configInline:
  address-pools:
   - name: default
     protocol: layer2
     addresses:
     - 10.0.0.240-10.0.0.250
EOF
helm repo add metallb https://metallb.github.io/metallb
helm repo update
helm install metallb metallb/metallb -f values.yaml -n metallb-system
rm values.yaml

kubectl create ns dev