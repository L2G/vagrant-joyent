source 'https://rubygems.org'

# Specify your gem's dependencies in vagrant-joyent.gemspec
gemspec

# See http://docs.vagrantup.com/v2/plugins/development-basics.html

group :development do
  gem 'vagrant', git: 'https://github.com/mitchellh/vagrant.git'
end

group :development, :test do
  gem 'vagrant-spec', github: 'mitchellh/vagrant-spec'
end

group :plugins do
  gem 'vagrant-joyent-L2G', path: '.'
end
