# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "public_network", ip: "192.168.0.101"
  config.vm.network "forwarded_port", guest: 82, host: 82
  config.vm.provider "virtualbox" do |vb|
	vb.name = "Ubuntu-nginx"
	vb.gui = false
	vb.memory = "2048"
	vb.cpus = 2
  end
  config.vm.hostname = "ubuntu-nginx"
  config.vm.provision "shell", path: "provision.sh"
  
end
