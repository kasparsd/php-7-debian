#!/bin/bash

# PHP 7

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
                  --with-config-file-scan-dir=/usr/local/php7/conf.d \
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

PATH=$PATH:/usr/local/php7/bin
echo 'export PATH="$PATH:/usr/local/php7/bin"' >> /etc/bash.bashrc

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

cd ../

# Symlink php-fpm to php7-fpm
ln -s /usr/local/php7/sbin/php-fpm /usr/local/php7/sbin/php7-fpm

# Add config files
cp php-src/php.ini-production /usr/local/php7/lib/php.ini
cp conf/www.conf /usr/local/php7/etc/php-fpm.d/www.conf
cp conf/php-fpm.conf /usr/local/php7/etc/php-fpm.conf

# Add the init script
cp conf/php7-fpm.init /etc/init.d/php7-fpm
chmod +x /etc/init.d/php7-fpm
update-rc.d php7-fpm defaults

service php7-fpm start

# Activate modules
#API_VERSION=`phpize -v | grep -i 'api version' | cut -d: -f2 | tr -d ' '` 
#echo "zend_extension=/usr/local/php7/lib/php/extensions/no-debug-non-zts-${API_VERSION}/opcache.so" > /etc/php7/conf.d/opcache.ini
#ln -s /etc/php7/conf.d/opcache.ini /etc/php7/cli/conf.d/opcache.ini
#ln -s /etc/php7/conf.d/opcache.ini /etc/php7/fpm/conf.d/opcache.ini
