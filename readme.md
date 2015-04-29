# Install PHP 7 on Debian/Ubuntu

These are a set of bash scripts for building and running PHP 7 (CLI and FPM) on Debian based Linux distributions:

- `builds.sh` installs the necessary build dependencies and the latest development version of PHP with CLI and FPM server APIs (SAPI) from the `master` branch of https://github.com/php/php-src
 
- `./install.sh` sets up PHP-FPM by moving configuration files into their correct locations in `/usr/local/php7` and enables the `php7-fpm` service and adds it to the startup sequence.

Please note that these are very simple scripts that don't implement error checking or process validation. You will probably need to run them with super user permissions (`sudo`).


## Usage

	git clone https://github.com/kasparsd/php-7-debian.git
	cd php-7-debian
	./build.sh
	./install.sh

The PHP-FPM can be operated using the `php7-fpm` init script:

	Usage: /etc/init.d/php7-fpm {start|stop|status|restart|reload|force-reload}

while the FPM socket is available at

	127.0.0.1:9007

and PHP CLI:
	
	$ /usr/local/php7/bin/php -v
	PHP 7.0.0-dev (cli) (built: Apr 23 2015 18:14:01) 
	Copyright (c) 1997-2015 The PHP Group
	Zend Engine v3.0.0-dev, Copyright (c) 1998-2015 Zend Technologies
	    with Zend OPcache v7.0.6-dev, Copyright (c) 1999-2015, by Zend Technologies

## Configuration files

All PHP configuration files are stored under `/usr/local/php7`:
	
	/usr/local/php7/lib/php.ini
	/usr/local/php7/etc/php-fpm.conf
	/usr/local/php7/etc/php-fpm.d/www.conf
	/usr/local/php7/etc/conf.d/modules.ini

while the Debian init script is added to:

	/etc/init.d/php7-fpm

## Extensions

Note that most of the third-party PHP extensions are [not yet compatible with PHP 7](https://github.com/gophp7/gophp7-ext/wiki/extensions-catalog) and [GoPHP7-ext](http://gophp7.org/) (also on [GitHub](https://github.com/gophp7/gophp7-ext)) is a project to help do that. Here is a list of PHP modules that are enabled by default in this build:

	$ /usr/local/php7/bin/php -m
	[PHP Modules]
	bcmath
	bz2
	calendar
	Core
	ctype
	curl
	date
	dba
	dom
	exif
	fileinfo
	filter
	ftp
	gd
	gettext
	hash
	iconv
	json
	libxml
	mbstring
	mcrypt
	mhash
	mysqli
	mysqlnd
	openssl
	pcntl
	pcre
	PDO
	pdo_mysql
	pdo_sqlite
	Phar
	posix
	pspell
	readline
	Reflection
	session
	shmop
	SimpleXML
	soap
	sockets
	SPL
	sqlite3
	standard
	sysvmsg
	sysvsem
	sysvshm
	tokenizer
	wddx
	xml
	xmlreader
	xmlwriter
	Zend OPcache
	zip
	zlib

	[Zend Modules]
	Zend OPcache

## Installing Memcached Extension

[Memcached extension for PHP](https://github.com/php-memcached-dev/php-memcached) already supports PHP 7 and here is a quick way to install it:

	git clone https://github.com/php-memcached-dev/php-memcached
	cd php-memcached
	git checkout -b php7 origin/php7

	/usr/local/php7/bin/phpize
	./configure --with-php-config=/usr/local/php7/bin/php-config
	make
	sudo make install

and then append `extension=memcached.so` to `/usr/local/php7/etc/conf.d/modules.ini`:

	# Zend OPcache
	zend_extension=opcache.so
	
	# Memcached
	extension=memcached.so


## Credits

- Created by [Kaspars Dambis](http://kaspars.net)
- Based on [`php7.sh`](https://gist.github.com/tvlooy/953a7c0658e70b573ab4) by [Tom Van Looy](http://www.intracto.com/nl/blog/running-symfony2-on-php7) 
