# `devfiles`
dotfiles and provisioning configurations by using Vagrant and Ansible

## Create base box

```shell-session
$ vagrant destroy -f      # remove old box
$ vagrant up --provision  # create new VM and run provision script
$ ./makebox.sh            # make box
```

```shell-session
$ vagrant box add my_dev ./package.box`
```

## Make your environment

```shell-session
$ mkdir yourenv && cd $_
$ vagrant init my_dev
$ edit ./config.yml
$ vagrant up --provision
```

```yaml
# basic configuration
dotfiles: https://github.com/your/dotfiles.git
tags: []
skip_tags: []

# VM configuration
mount:
  - name: dropbox
    path: "$HOME/Dropbox"
network:
  - type: bridge
```
