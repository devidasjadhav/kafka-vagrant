# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  (1..3).each do |i|
    config.vm.define "kafka#{i}" do |node|
      node.vm.box               = "debian/bookworm64"
      node.vm.hostname          = "kafka#{i}"

      #node.vm.network "public_network"
      node.vm.network "private_network", ip: "192.168.199.1#{i}"
    
      node.vm.provision "shell", path: "kafka.sh"
      node.vm.provider :virtualbox do |v|
        v.name    = "kafka#{i}"
        v.memory  = 2048
        v.cpus    = 1
      end
    end
  end
end
