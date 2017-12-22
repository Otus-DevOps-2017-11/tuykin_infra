#!/bin/bash

echo 'This should be working'
echo 'Installing Ruby'
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

echo 'Ruby and Bundler are installed:'
ruby -v
bundler -v

echo "Installing MongoDB..."
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

sudo apt update
sudo apt install -y mongodb-org

echo "Starting MongoDB"
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod

echo "Deploying app..."

echo "Clonning repo"
cd $HOME
git clone https://github.com/Otus-DevOps-2017-11/reddit.git

echo "Installing gems"
cd reddit && bundle install

echo "Starting app"
puma -d
ps aux | grep puma
