#!/bin/sh

echo "Deploying app..."

echo "Clonning repo"
git clone https://github.com/Otus-DevOps-2017-11/reddit.git

echo "Installing gems"
cd reddit && bundle install

echo "Starting app"
puma -d
ps aux | grep puma
