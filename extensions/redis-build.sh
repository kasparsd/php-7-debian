#!/bin/bash
cd "$(dirname "$0")"

# Dependencies
sudo apt-get update
sudo apt-get install -y \
    redis-server

git clone https://github.com/phpredis/phpredis.git
cd phpredis

# Fetch the latest changes
git fetch --tags --prune

# Get the latest tag
TAG=$(git describe --tags $(git rev-list --tags --max-count=1))

git checkout -f tags/$TAG
git reset --hard

/usr/local/php7/bin/phpize
./configure --with-php-config=/usr/local/php7/bin/php-config

make
sudo make install
