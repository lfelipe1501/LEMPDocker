#!/bin/bash

#
# Script to create MariaDB db + user and phpMyAdmin tool deploy.
#
# @author   Luis Felipe <lfelipe1501@gmail.com>
# @website  https://www.lfsystems.com.co
# @version  1.0

SQL1="CREATE DATABASE IF NOT EXISTS ${DBUP}; CREATE USER IF NOT EXISTS '${USERDB}'@'%' IDENTIFIED BY '${UPWDB}';"
SQL2="GRANT USAGE ON *.* TO '${USERDB}'@'%' IDENTIFIED BY '${UPWDB}'; GRANT ALL privileges ON ${DBUP}.* TO '${USERDB}'@'%' WITH GRANT OPTION;"
SQL3="FLUSH PRIVILEGES;"
SQL4="USE ${DBUP}; CREATE TABLE test_content ( id int(11) NOT NULL, mensaje text NOT NULL, nulo int(11) DEFAULT NULL) ENGINE=InnoDB DEFAULT CHARSET=latin1; INSERT INTO test_content (id, mensaje, nulo) VALUES (1, 'All systems and containers working!', NULL); ALTER TABLE test_content ADD PRIMARY KEY (id); COMMIT;"

mariadb -u root -p$MARIADB_ROOT_PASSWORD -e "${SQL1}${SQL2}${SQL3}${SQL4}"

## Download phpMyAdmin
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz | tar -xvf /pma

## Download config for phpMyAdmin
wget https://gist.githubusercontent.com/lfelipe1501/467245c263c90319b103093a40fe96b7/raw/c292f8df56a307bdaabd2369830e30d155cf49a2/config.inc.php -o /pma/config.inc.php