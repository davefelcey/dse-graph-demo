# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
 
    # Customize the amount of memory on the VM:
    vb.memory = "4096"
  end

  config.vm.define "testnode1" do |testnode1|
    testnode1.vm.hostname = "node1"
    testnode1.vm.network "private_network", ip: "192.168.56.211"

    # Copy customer graph example to new VM
    testnode1.vm.provision "file", source: "cust-examples.tar.gz", destination: "cust-examples.tar.gz"

    # Install Java
    testnode1.vm.provision "shell", path: "install-java.sh"

    # Install and DSE and Studio, configure and start them both
    testnode1.vm.provision "shell", path: "install-dse.sh"
  end

end
