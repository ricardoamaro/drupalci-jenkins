# Drupal CI Jenkins.
#
# Provides a local development environment for Drupal's Continuous Integration
# Jenkins based platform.
#

domain = 'local'
nodes = [
  {
    :hostname => 'master',
    :ip => '192.168.1.52',
    :box => 'precise32',
    :ram => 1024,
    :facts => {
      "vagrant" => "1",
      "jenkins_role" => "master"
    }
  },{
    :hostname => 'slave1',
    :ip => '192.168.1.53',
    :box => 'precise32',
    :ram => 1024,
    :facts => {
      "vagrant" => "1",
      "jenkins_role" => "slave",
      "jenkins_master" => "192.168.1.52"
    }
  },{
    :hostname => 'slave2',
    :ip => '192.168.1.54',
    :box => 'precise32',
    :ram => 1024,
    :facts => {
      "vagrant" => "1",
      "jenkins_role" => "slave",
      "jenkins_master" => "192.168.1.52"
    }
  }
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = 'precise64'
      node_config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
      node_config.vm.host_name = node[:hostname] + '.local'
      node_config.vm.network :private_network, :ip => node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      node_config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--name", node[:hostname]]
        vb.customize ["modifyvm", :id, "--memory", memory.to_s]
      end

      config.vm.synced_folder ".", "/vagrant"

      config.vm.provision "shell", path: "puppet/provision.sh"
      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet'
        puppet.manifest_file = 'site.pp'
        puppet.module_path = 'puppet/modules'
        puppet.hiera_config_path = "puppet/etc/hiera.yaml"
        puppet.working_directory = "/vagrant/puppet"
        puppet.facter = node[:facts]
      end
    end
  end
end
