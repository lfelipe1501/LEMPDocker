#!/bin/sh

# Time zone set according to the country set in the .env file
echo ""
echo "Time zone update to: " $TZ
cat /usr/share/zoneinfo/$TZ > /etc/localtime
echo ""
echo $TZ > /etc/timezone

## Install phpMyAdmin Manager for MariaDB
if [ -d /var/www/html/pma ]; then
  if [ -z "$(ls /var/www/html/pma)" ]; then
  ## Download phpMyAdmin
  cd /var/www/html/pma && wget -q https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip && unzip phpMyAdmin-latest-all-languages.zip && mv phpMyAdmin-*-all-languages/* . && rm -rf phpMyAdmin-*-all-languages phpMyAdmin-latest-all-languages.zip

  ## Download config for phpMyAdmin
  cd /var/www/html/pma && wget https://gist.githubusercontent.com/lfelipe1501/467245c263c90319b103093a40fe96b7/raw/76b7bdc1ef31257b129698e772978d1d17f2e186/config.inc.php
  fi
fi

php-fpm${VPHP} -F -R -O
