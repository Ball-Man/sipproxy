# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'

file = File.open("config.json")
config_data = JSON.parse(file.read)
file.close

# Check for necessary plugins
unless Vagrant.has_plugin?("vagrant-disksize")
  raise Vagrant::Errors::VagrantError.new, "vagrant-disksize plugin is required"
end

Vagrant.configure("2") do |config|
  config_data.each do |name_, v_data|
    config.vm.define name_ do |v|
      # Box name
      v.vm.box = v_data["box"]

      # Disk size
      v.disksize.size = v_data["min_storage"]

      # Provider specific
      v.vm.provider v_data["provider"] do |v|
        v.name = name_
      	v.memory = v_data["memory"]
        v.cpus = v_data["cpus"]
      end

      # Network
      v_data["networks"]&.each do |net|
        v.vm.network net["type"], ip: net["ip"]
      end

      # Forwarded ports
      v_data["ports"]&.each do |port|
      	v.vm.network :forwarded_port, guest: port["guest"], host: port["host"], protocol: port["protocol"]
      end

      # Provisioning
      v_data["provisioning"]&.each do |provision|
        case provision["provisioner"]
        when "shell"
          v.vm.provision provision["provisioner"], path: provision["path"], privileged: provision["privileged"], args: provision["args"]
        end
      end

      # Synced folders
      v_data["synced_folders"]&.each do |folder|
        v.vm.synced_folder folder["host"], folder["guest"]
      end
    end
  end
end

