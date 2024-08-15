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
  cd /var/www/html/pma && wget https://gist.githubusercontent.com/lfelipe1501/6ae9cadf1ca52ad4868a904207f70ce7/raw/276d7898848afea3cf475f3e96c6db6cb9c7b6e0/config.inc.php

  ## Create DB and set User for phpMyAdmin
  
  fi
fi

php-fpm${VPHP} -F -R -O
