# Install PHP 7 (CLI and FPM) on Debian Wheezy

Uses the latest source of PHP from the `master` branch of https://github.com/php/php-src.

## Install

	git clone https://github.com/kasparsd/php-7-debian.git
	cd php-7-debian
	./install.sh

The PHP-FPM is be available at `127.0.0.1:9007`

## Configuration files

All package files are stored under `/usr/local/php7`.

## Credits

- Created by [Kaspars Dambis](http://kaspars.net)
- Based on [`php7.sh` by Tom Van Looy](http://www.intracto.com/nl/blog/running-symfony2-on-php7) 
