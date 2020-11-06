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
  # Box name
  config.vm.box = config_data["box"]

  # Disk size
  config.disksize.size = config_data["min_storage"]

  # Provider specific
  config.vm.provider config_data["provider"] do |v|
    v.name = config_data["name"]
  	v.memory = config_data["memory"]
    v.cpus = config_data["cpus"]
  end

  # Network
  config_data["networks"].each do |net|
    config.vm.network net["type"], ip: net["ip"]
  end

  # Forwarded ports
  config_data["ports"].each do |port|
  	config.vm.network :forwarded_port, guest: port["guest"], host: port["host"], protocol: port["protocol"]
  end

  # Provisioning
  config_data["provisioning"].each do |provision|
    case provision["provisioner"]
    when "shell"
      config.vm.provision provision["provisioner"], path: provision["path"], privileged: provision["privileged"], args: provision["args"]
    end
  end

end

