#!/bin/bash --login

cd /vagrant

# update the package manager
apt-get update && sudo -E apt-get upgrade -y

# install git
sudo -E apt-get install -y git

# install PostgreSQL (DB)
sudo -E /usr/sbin/update-locale LANG=en_US.UTF-8 LC_ALL=en_us.UTF-8
sudo -E apt-get install -y postgresql libpq-dev

# other stuff
sudo -E apt-get install -y build-essential curl ruby-dev libxml2 libxml2-dev libxslt1-dev

# rbenv (Ruby Version Manager)
sudo -u vagrant git clone https://github.com/sstephenson/rbenv.git /home/vagrant/.rbenv
sudo -u vagrant echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/vagrant/.bashrc
sudo -u vagrant echo 'eval "$(rbenv init -)"' >> /home/vagrant/.bashrc
sudo -u vagrant git clone https://github.com/sstephenson/ruby-build.git /home/vagrant/.rbenv/plugins/ruby-build

# ...install a Ruby and the Bundler gem
source ~/.bashrc
sudo -u vagrant -i rbenv install 2.2.3
sudo -u vagrant -i rbenv global 2.2.3
sudo -u vagrant -i gem install bundler --no-ri --no-rdoc
sudo -u vagrant -i rbenv rehash

echo "cd /vagrant" >> /home/vagrant/.bashrc
