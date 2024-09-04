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
  cd /var/www/html/pma && wget -q https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip\
  && unzip phpMyAdmin-latest-all-languages.zip && mv phpMyAdmin-*-all-languages/* .\
  && rm -rf phpMyAdmin-*-all-languages phpMyAdmin-latest-all-languages.zip

  ## Download config for phpMyAdmin
  cd /var/www/html/pma && curl -L https://gist.github.com/lfelipe1501/6ae9cadf1ca52ad4868a904207f70ce7/raw/ -o config.inc.php
  fi
fi

php-fpm${VPHP} -F -R -O
