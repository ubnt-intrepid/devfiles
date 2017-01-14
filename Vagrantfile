# -*- mode: ruby -*-
# vim: set ft=ruby ts=2 sw=2 et :

require 'yaml'

class MountEntry
  def initialize(node)
    @name = node['name']
    @path = node['path'].gsub(/\$\w+/) { |m| ENV[m[1..-1]] }
  end

  def apply(config)
    config.vm.synced_folder @path, "/mnt/#{@name}", \
      mount_options: ['dmode=775', 'fmode=664']
  end
end

class NetworkEntry
  def initialize(node)
    @type = node['type']
  end

  def apply(config)
    # config.vm.network "forwarded_port", guest:8888, host:8000
    # config.vm.network "private_network", ip: "192.168.56.101"
    if @type == "bridge" then
      config.vm.network "public_network"
    end
  end
end

class UserConfig
  def initialize(filename)
    settings = YAML.load_file filename

    # The URL of repository which contains guest's configuration files (a.k.a 'dotfiles')
    @dotfiles = settings['dotfiles']
    # mount points of host PC
    @mounts = settings['mount'].map { |node| MountEntry.new(node) }
    # Whether to use bridge network
    @networks = settings['network'].map { |node| NetworkEntry.new(node) }
    @tags = settings['tags'] or []
    @skip_tags = settings['skip_tags'] or []
  end

  def apply(config)
    config.vm.box = "wholebits/fedora25-64"

    config.vm.provider "virtualbox" do |vb|
      vb.memory = 4096
      vb.customize ["modifyvm", :id, "--audio", "null"]
      vb.customize ["modifyvm", :id, "--vram", "256"]
      vb.customize ["modifyvm", :id, "--cpus", 2, "--ioapic", "on"]
    end

    if Vagrant.has_plugin?("vagrant-vbguest") then
      config.vbguest.auto_update = false
    end

    config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=775', 'fmode=664']
    @mounts.each { |entry| entry.apply(config) }

    @networks.each { |entry| entry.apply(config) }

    config.vm.provision :shell, inline: <<-SHELL
      dnf upgrade -y
      dnf install -y git ansible python2 python2-dnf libselinux-python
    SHELL

    config.vm.provision :shell, privileged: false, inline: <<-SHELL
      [[ -d $HOME/.dotfiles ]] || git clone --recursive "#{@dotfiles}" $HOME/.dotfiles
    SHELL

    config.vm.provision :ansible_local do |ansible|
      ansible.playbook          = "/home/vagrant/.dotfiles/playbook/site.yml"
      ansible.inventory_path    = "/home/vagrant/.dotfiles/playbook/hosts"
      ansible.install           = true
      ansible.limit             = "all"
      ansible.tags              = @tags
      ansible.skip_tags         = @skip_tags
    end

    config.vm.provision :file, source: "~/.gitconfig", destination: "~/.gitconfig"
  end
end

user = UserConfig.new 'config.yml'

Vagrant.configure("2") { |config| user.apply(config) }
