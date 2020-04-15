#!/bin/bash
cd "$(dirname "$0")"

# Use all cores for the build process
CORE_COUNT=$(cat /proc/cpuinfo | grep -c processor)

# Allow JOB_COUNT environment variable to override the job count
JOB_COUNT=${JOB_COUNT:-$CORE_COUNT}

# Dependencies
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    pkg-config \
    git-core \
    autoconf \
    bison \
    re2c \
    libonig-dev \
    libsqlite3-dev \
    libxml2-dev \
    libbz2-dev \
    libicu-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libltdl-dev \
    libjpeg-dev \
    libpng-dev \
    libpspell-dev \
    libreadline-dev

sudo mkdir /usr/local/php7

git clone https://github.com/php/php-src.git
cd php-src
git fetch --tags --prune
git checkout tags/php-7.4.5
./buildconf --force

CONFIGURE_STRING="--prefix=/usr/local/php7 \
                  --enable-huge-code-pages \
                  --with-config-file-scan-dir=/usr/local/php7/etc/conf.d \
                  --enable-bcmath \
                  --with-bz2 \
                  --enable-calendar \
                  --enable-intl \
                  --enable-exif \
                  --enable-dba \
                  --enable-ftp \
                  --with-gettext \
                  --with-gd \
                  --with-jpeg-dir \
                  --enable-mbstring \
                  --with-mhash \
                  --enable-mysqlnd \
                  --with-mysqli \
                  --with-mysql-sock=yes \
                  --with-pdo-mysql \
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
                  --without-libzip \
                  --with-readline \
                  --with-curl \
                  --enable-fpm \
                  --with-fpm-user=www-data \
                  --with-fpm-group=www-data"

./configure $CONFIGURE_STRING

make -j "$JOB_COUNT"
sudo make install
