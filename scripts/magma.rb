class Magma
  def Magma.configure(config, settings)
    # Configure The Box
    config.vm.box = "rossedman/magma"
    config.vm.hostname = "magma"

    # Configure A Private Network IP
    config.vm.network :private_network, ip: settings["ip"] ||= "192.168.10.30"

    # Configure A Few VirtualBox Settings
    config.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
      vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
      vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    # Configure Port Forwarding To The Box
    config.vm.network "forwarded_port", guest: 80, host: 8000
    config.vm.network "forwarded_port", guest: 3306, host: 33666

    # Configure The Public Key For SSH Access
    config.vm.provision "shell" do |s|
      s.inline = "echo $1 | tee -a /home/vagrant/.ssh/authorized_keys"
      s.args = [File.read(File.expand_path(settings["authorize"]))]
    end

    # Copy The SSH Private Keys To The Box
    settings["keys"].each do |key|
      config.vm.provision "shell" do |s|
        s.privileged = false
        s.inline = "echo \"$1\" > /home/vagrant/.ssh/$2 && chmod 600 /home/vagrant/.ssh/$2"
        s.args = [File.read(File.expand_path(key)), key.split('/').last]
      end
    end

    # Copy The Bash Aliases
    config.vm.provision "shell" do |s|
      s.inline = "cp /vagrant/aliases /home/vagrant/.bash_aliases"
    end

    # Register All Of The Configured Shared Folders
    settings["folders"].each do |folder|
      config.vm.synced_folder folder["map"], folder["to"], type: folder["type"] ||= nil
    end

    # Install All The Configured Nginx Sites
    settings["sites"].each do |site|
      config.vm.provision "shell" do |s|
        s.inline = "bash /vagrant/scripts/serve.sh $1 $2"
        s.args = [site["map"], site["to"]]
      end
    end

  end
end