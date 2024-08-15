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
SQL5="CREATE DATABASE IF NOT EXISTS phpmyadmin; GRANT ALL privileges ON phpmyadmin.* TO '${USERDB}'@'%' WITH GRANT OPTION; COMMIT;"

mariadb -u root -p$MARIADB_ROOT_PASSWORD -e "${SQL1}${SQL2}${SQL3}${SQL4}${SQL5}"
