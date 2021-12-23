IMAGE = "bento/ubuntu-20.04"
WORKER_NODE_NB = 2
WORKER_CPU = 2
WORKER_RAM = 2048
MASTER_CPU = 2
MASTER_RAM = 4096

Vagrant.configure("2") do |config|

    # master-node VM
    config.vm.define "master-node" do |master|
        master.vm.provider "virtualbox" do |vb|
            vb.name = "master-node"
            vb.memory = MASTER_RAM
            vb.cpus = MASTER_CPU
        end
        master.vm.box = IMAGE
        master.vm.hostname = "master-node"
        master.vm.network "private_network", ip: "10.0.0.20"
    end

    # Worker-node(s) VM(s)
    (1..WORKER_NODE_NB).each do |i|
        config.vm.define "worker-node0#{i}" do |worker|
            worker.vm.provider "virtualbox" do |vb|
                vb.name = "worker-node0#{i}"
                vb.memory = WORKER_RAM
                vb.cpus = WORKER_CPU
            end
            worker.vm.box = IMAGE
            worker.vm.hostname = "worker-node0#{i}"
            worker.vm.network "private_network", ip: "10.0.0.#{i + 20}"
        end
    end

end
