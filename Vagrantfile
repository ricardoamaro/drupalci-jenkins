# Drupal CI Jenkins.
#
# Provides a local development environment for Drupal's Continuous Integration
# Jenkins based platform.
#

domain = 'local'
nodes = [
  { :hostname => 'master', :jenkins_role => "master", :ip => '192.168.1.52', :box => 'precise32', :ram => 1024 },
  { :hostname => 'slave1', :jenkins_role => "slave",  :ip => '192.168.1.53', :box => 'precise32', :ram => 1024 },
  { :hostname => 'slave2', :jenkins_role => "slave",  :ip => '192.168.1.54', :box => 'precise32', :ram => 1024 }
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = 'precise64'
      node_config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
      node_config.vm.host_name = node[:hostname] + '.local'
      node_config.vm.network :private_network, :ip => node[:ip]

      memory = node[:ram] ? node[:ram] : 256;
      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--name", node[:hostname]]
        vb.customize ["modifyvm", :id, "--memory", memory.to_s]
      end

      # We want to cater for both Unix and Windows.
      if RUBY_PLATFORM =~ /linux|darwin/
        config.vm.synced_folder(
          ".",
          "/vagrant",
          :nfs => true,
          :map_uid => 0,
          :map_gid => 0,
         )
      else
        config.vm.synced_folder ".", "/vagrant"
      end

      config.vm.provision "shell", path: "puppet/provision.sh"
      node_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet'
        puppet.manifest_file = 'site.pp'
        puppet.module_path = 'puppet/modules'
        puppet.hiera_config_path = "puppet/etc/hiera.yaml"
        puppet.working_directory = "/vagrant/puppet"
        puppet.facter = {
          "vagrant" => "1",
          "jenkins_role" => node[:jenkins_role]
        }
      end
    end
  end
end
