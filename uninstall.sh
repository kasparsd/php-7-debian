#!/bin/bash

sudo service php7-fpm stop

rm -rf /usr/local/php7
rm /etc/init.d/php7-fpm

update-rc.d php7-fpm remove

