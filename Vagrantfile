VAGRANTFILE_API_VERSION = "2"

path = "#{File.dirname(__FILE__)}"

require 'yaml'
require path + '/scripts/magma.rb'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  Magma.configure(config, YAML::load(File.read(path + '/Magma.yaml')))
end