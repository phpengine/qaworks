# -*- mode: ruby -*-
# vi: set ft=ruby :
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
      sudo bash /vagrant/build/config/shell/boxprep.sh
  SHELL

#  id_rsa_ssh_key = File.read(File.join(Dir.home, ".ssh", "id_rsa"))
#  id_rsa_ssh_key_pub = File.read(File.join(Dir.home, ".ssh", "id_rsa.pub"))
#  config.vm.provision :shell, :inline => "echo 'Copying local id_rsa SSH Key to VM for git and auth purposes (login included)...' && echo '#{id_rsa_ssh_key }' > /home/vagrant/.ssh/id_rsa && chmod 600 /home/vagrant/.ssh/id_rsa && chown -R vagrant /home/vagrant/.ssh"
#  config.vm.provision :shell, :inline => "echo 'Copying local id_rsa SSH Key to VM for Jenkins git and auth purposes (login included)...' && echo '#{id_rsa_ssh_key }' > /var/lib/jenkins/.ssh/id_rsa && chmod 600 /var/lib/jenkins/.ssh/id_rsa && chown -R jenkins /var/lib/jenkins/.ssh"
#  config.vm.provision :shell, :inline => "echo 'Copying local id_rsa.pub SSH Key to VM auth_keys for auth purposes (login into VM included)...' && echo '#{id_rsa_ssh_key_pub }' >> /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys"

end