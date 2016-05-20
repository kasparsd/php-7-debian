#!/bin/bash

# Add config files
echo "extension=imagick.so" >> /usr/local/php7/etc/conf.d/modules.ini

service php7-fpm restart
