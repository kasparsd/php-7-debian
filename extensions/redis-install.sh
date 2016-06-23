#!/bin/bash

# Enable the module
echo "extension=redis.so" | sudo tee -a /usr/local/php7/etc/conf.d/modules.ini
