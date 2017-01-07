# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "wholebits/fedora25-64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--audio", "null"]
    vb.customize ["modifyvm", :id, "--vram", "256"]
    vb.customize ["modifyvm", :id, "--cpus", "2", "--ioapic", "on"]
  end

  config.vm.synced_folder ".",       "/vagrant",  mount_options: ['dmode=775', 'fmode=664']
  config.vm.synced_folder "c:/work", "/mnt/work", mount_options: ['dmode=775', 'fmode=664']

  # config.vm.network "forwarded_port", guest:8888, host:8000
  # config.vm.network "private_network", ip: "192.168.56.101"
  # config.vm.network "public_network"

  config.vm.provision :shell, privileged: false, inline: <<-SHELL
    sudo dnf install -y git
    git clone https://github.com/ubnt-intrepid/dotfiles.git ~/.dotfiles
  SHELL

  config.vm.provision :ansible_local do |ansible|
    ansible.playbook          = "/home/vagrant/.dotfiles/site.yml"
    ansible.inventory_path    = "/home/vagrant/.dotfiles/hosts"
    ansible.verbose           = true
    ansible.install           = true
    ansible.limit             = "all"
  end

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
end
