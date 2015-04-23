#!/bin/bash

# Dependencies
apt-get update
apt-get install -y \
    build-essential \
    git-core \
    autoconf \
    bison \
    libxml2-dev \
    libbz2-dev \
    libmcrypt-dev \
    libcurl4-openssl-dev \
    libltdl-dev \
    libpng-dev \
    libpspell-dev \
    libreadline-dev

mkdir /usr/local/php7

git clone https://github.com/php/php-src.git
cd php-src
./buildconf

CONFIGURE_STRING="--prefix=/usr/local/php7 \
                  --with-config-file-scan-dir=/usr/local/php7/etc/conf.d \
                  --enable-bcmath \
                  --with-bz2 \
                  --enable-calendar \
                  --enable-exif \
                  --enable-dba \
                  --enable-ftp \
                  --with-gettext \
                  --with-gd \
                  --enable-mbstring \
                  --with-mcrypt \
                  --with-mhash \
                  --enable-mysqlnd \
                  --with-mysql=mysqlnd \
                  --with-mysql-sock=/var/run/mysqld/mysqld.sock \
                  --with-mysqli=mysqlnd \
                  --with-pdo-mysql=mysqlnd \
                  --with-openssl \
                  --enable-pcntl \
                  --with-pspell \
                  --enable-shmop \
                  --enable-soap \
                  --enable-sockets \
                  --enable-sysvmsg \
                  --enable-sysvsem \
                  --enable-sysvshm \
                  --enable-wddx \
                  --with-zlib \
                  --enable-zip \
                  --with-readline \
                  --with-curl"

# Build CLI
./configure \
    $CONFIGURE_STRING

make
make install

# Build FPM
make clean

./configure \
    $CONFIGURE_STRING \
    --disable-cli \
    --enable-fpm \
    --with-fpm-user=www-data \
    --with-fpm-group=www-data

make
make install

# Add php bin to bash path
PATH=$PATH:/usr/local/php7/bin
echo 'export PATH="$PATH:/usr/local/php7/bin"' >> /etc/bash.bashrc
