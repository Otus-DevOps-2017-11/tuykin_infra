#!/bin/sh

echo 'Installing Ruby'
apt update
apt install -y ruby-full ruby-bundler build-essential

echo 'Ruby and Bundler are installed:'
ruby -v
bundler -v
