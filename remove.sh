#!/bin/bash

/etc/init.d/php7-fpm stop
rm -r /usr/local/php7
update-rc.d php7-fpm remove
rm /etc/init.d/php7-fpm
