#!/bin/bash
cd "$(dirname "$0")"

# Symlink php-fpm to php7-fpm
ln -s /usr/local/php7/sbin/php-fpm /usr/local/php7/sbin/php7-fpm

# Add config files
cp php-src/php.ini-production /usr/local/php7/lib/php.ini
cp conf/www.conf /usr/local/php7/etc/php-fpm.d/www.conf
cp conf/php-fpm.conf /usr/local/php7/etc/php-fpm.conf
cp conf/modules.ini /usr/local/php7/etc/conf.d/modules.ini

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
