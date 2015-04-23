# Install PHP 7 (CLI and FPM) on Debian Wheezy

Uses the latest source of PHP from the `master` branch of https://github.com/php/php-src.


## Install

	git clone https://github.com/kasparsd/php-7-debian.git
	cd php-7-debian
	./build.sh
	./install.sh

The PHP-FPM can be operated using the `php7-fpm` init script:

	Usage: /etc/init.d/php5-fpm {start|stop|status|restart|reload|force-reload}

while the socket is available at

	127.0.0.1:9007


## Configuration files

All PHP configuration files are stored under `/usr/local/php7`:
	
	/usr/local/php7/lib/php.ini
	/usr/local/php7/etc/php-fpm.conf
	/usr/local/php7/etc/php-fpm.d/www.conf
	/usr/local/php7/etc/conf.d/modules.ini

while the Debian init script is added to:

	/etc/init.d/php7-fpm


## Credits

- Created by [Kaspars Dambis](http://kaspars.net)
- Based on [`php7.sh`](https://gist.github.com/tvlooy/953a7c0658e70b573ab4) by [Tom Van Looy](http://www.intracto.com/nl/blog/running-symfony2-on-php7) 
