# vim: set ft=ruby ts=2 sw=2 et :

Vagrant.configure("2") do |config|
  config.vm.box = "wholebits/fedora25-64"

  config.vm.provision :shell, inline: <<-SHELL
    dnf upgrade -y
    dnf install -y git ansible python2 python2-dnf libselinux-python
  SHELL
end
