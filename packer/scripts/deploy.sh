#!/bin/sh
set -e

APP_DIR=${1:-$HOME}

echo "Deploying app..."

echo "Clonning repo"
git clone https://github.com/Otus-DevOps-2017-11/reddit.git $APP_DIR/reddit

echo "Installing gems"
cd $APP_DIR/reddit
bundle install

echo "Starting app"
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
