#!/bin/sh

echo 'Installing Ruby'
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

echo 'Ruby and Bundler are installed:'
ruby -v
bundler -v
