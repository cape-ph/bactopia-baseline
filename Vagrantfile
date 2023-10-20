# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["VAGRANT_EXPERIMENTAL"] = "disks"

options = {
    basebox_name:  "bento/amazonlinux-2",
    basebox_version: "202305.26.0",
}


# Install Ansible using hack since we can't install epel as default workflow
# expects
$script = <<-SCRIPT
echo Installing Ansible from amazon-linux-extras...
yum update -y
amazon-linux-extras install ansible2 -y
SCRIPT

Vagrant.configure(2) do |config|

    config.vm.box =  options[:basebox_name]
    config.vm.box_version =  options[:basebox_version]
    config.vm.box_download_insecure = true

    config.vm.define "bactopia_baseline" do |bactopia_baseline|
        # hostname of the VM.
        # NOTE: this is used in the ansible hosts file for the local-dev
        #       environment
        bactopia_baseline.vm.hostname = "bactopia-baseline"

        # ssh
        bactopia_baseline.vm.network :forwarded_port,
            guest: 22,
            host: 2222,
            id: "ssh"

        # http - will redirect to https
        bactopia_baseline.vm.network :forwarded_port,
            guest: 80,
            host: 8080

        # https
        bactopia_baseline.vm.network :forwarded_port,
            guest: 443,
            host: 8443

        # shared host directory for the VM. we mount the parent directory of the
        # repo to /vagrant_data in the VM. if the standard "Getting Started"
        # (from the README) setup is used, this will give us access to the
        # software repo in the VM as well, allowing us to rebuild development
        # docker container images
        bactopia_baseline.vm.synced_folder "./output", "/output", create: true

        # NOTE: requires env where vagrant is run to have exported env var like
        # `export VAGRANT_EXPERIMENTAL="disks"`
        bactopia_baseline.vm.disk :disk, size: "50GB", primary: true

        bactopia_baseline.vm.provider "virtualbox" do |v|
            v.memory = 8192
            v.cpus = 4
            v.customize ['modifyvm', :id, '--cableconnected1', 'on']
            # use the host to resolve DNS.
            v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        end

        # Install ansible
        bactopia_baseline.vm.provision "shell", inline: $script 

        # run the ansible playbook to setup the machine
        bactopia_baseline.vm.provision "ansible_local" do |ansible|
            ansible.compatibility_mode = "2.0"
            ansible.extra_vars = {
                env: "local-dev",
            }

            ansible.install_mode = :default
            ansible.playbook = "playbook.yml"
            ansible.inventory_path = "environments/local-dev"
            ansible.limit='all'
            #ansible.vault_password_file='./vault/local-dev-vault'
            #ansible.galaxy_role_file='./dev-dependencies/ansible-roles.yml'
            # if not specified, the roles will be installed to `/vagrant` in the
            # VM, which is a shared directory that points to the root of this
            # repo (causing roles to end up as appearing to be part of this
            # repo, which isn't great)
            #ansible.galaxy_roles_path="/home/vagrant/roles"

            # NOTE: uncomment this if you wanna debug some verbose ansibles
            #ansible.verbose='-vvvvv'
        end
    end
end
