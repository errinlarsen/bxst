#!/bin/bash --login

cd /vagrant

# update the package manager
apt-get update && sudo apt-get upgrade -y

# install git
sudo apt-get install -y git

# install PostgreSQL (DB)
sudo apt-get install -y postgresql libpq-dev

# other stuff
sudo apt-get install -y build-essential curl ruby-dev libxml2 libxml2-dev libxslt1-dev

# rbenv (Ruby Version Manager)
sudo -u vagrant git clone https://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.profile
sudo -u vagrant echo 'eval "$(rbenv init -)"' >> /home/vagrant/.profile
sudo -u vagrant git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

# ...install a Ruby and the Bundler gem
sudo -u vagrant -i rbenv install 2.2.3
sudo -u vagrant -i rbenv global 2.2.3
sudo -u vagrant -i gem install bundler --no-ri --no-rdoc
sudo -u vagrant -i rbenv rehash

echo "cd /vagrant" >> /home/vagrant/.bashrc
