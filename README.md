# kubeadm-vagrant-cluster

Deploy a local kubernetes cluster using vagrant and kubeadm.
Simply use `vagrant up` to create a multi-node cluster.

```sh
> cd kubeadm-vagrant-cluster
> vagrant up
```

## Prerequisites

- [Vagrant](https://www.vagrantup.com/downloads)
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Specs

Kubernetes version: 1.23  
CRI: [Containerd](https://github.com/containerd/containerd)  
CNI: [Calico](https://projectcalico.docs.tigera.io/about/about-calico)

By default it will create a 3 nodes cluster with the following:
- Linux: ubuntu 20.04
- Master node: 2 CPU and 4096 MB RAM
- Workers node: 2 CPU and 2048 MB RAM

Metrics server is also available.

Everything have variable at the top of `Vagrantfile`, you can easily change it based on your need.
