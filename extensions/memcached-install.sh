#!/bin/bash

# Add config files
echo "zend_extension=memcached.so" >> /usr/local/php7/etc/conf.d/modules.ini

service php7-fpm restart
