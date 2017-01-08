# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

class UserConfig
  def initialize(filename)
    settings = YAML.load_file filename

    # The URL of repository which contains guest's configuration files (a.k.a 'dotfiles')
    @dotfiles = settings['dotfiles']
    # Working directory of host PC
    @working_dir = settings['working_dir']
    # Memory size of guest VM
    @memory = settings['memory']
    # The number of CPUs of guest VM
    @cpus = settings['cpus']
    # Provisioning by using ansible
    @run_ansible = settings['run_ansible']
    # Whether to use bridge network
    @enable_bridge = settings['enable_bridge']
  end

  def apply(config)
    config.vm.box = "wholebits/fedora25-64"

    config.vm.provider "virtualbox" do |vb|
      vb.memory = @memory
      vb.customize ["modifyvm", :id, "--audio", "null"]
      vb.customize ["modifyvm", :id, "--vram", "256"]
      vb.customize ["modifyvm", :id, "--cpus", @cpus, "--ioapic", "on"]
    end

    if Vagrant.has_plugin?("vagrant-vbguest") then
      config.vbguest.auto_update = false
    end

    config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=775', 'fmode=664']
    config.vm.synced_folder @working_dir, "/mnt/work", mount_options: ['dmode=775', 'fmode=664']

    # config.vm.network "forwarded_port", guest:8888, host:8000
    # config.vm.network "private_network", ip: "192.168.56.101"
    if @enable_bridge then
      config.vm.network "public_network"
    end

    config.vm.provision :shell, privileged: false, inline: <<-SHELL
      sudo dnf install -y ansible git
      if [[ ! -d $HOME/.dotfiles ]]; then
        git clone "#{@dotfiles}" $HOME/.dotfiles
      fi
    SHELL

    if @run_ansible then
      config.vm.provision :ansible_local do |ansible|
        ansible.playbook          = "/home/vagrant/.dotfiles/playbook/site.yml"
        ansible.inventory_path    = "/home/vagrant/.dotfiles/playbook/hosts"
        ansible.verbose           = true
        ansible.install           = true
        ansible.limit             = "all"
      end
    end
  end
end

user = UserConfig.new 'config.yml'

Vagrant.configure("2") { |config| user.apply(config) }
