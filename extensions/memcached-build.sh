#!/bin/bash
cd "$(dirname "$0")"

# Dependencies
sudo apt-get update
sudo apt-get install -y \
    libmemcached-dev \
    libmemcached11

git clone https://github.com/php-memcached-dev/php-memcached
cd php-memcached
git checkout php7
git pull

/usr/local/php7/bin/phpize
./configure --with-php-config=/usr/local/php7/bin/php-config

make
sudo make install
