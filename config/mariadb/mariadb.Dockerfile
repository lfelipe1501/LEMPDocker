FROM mariadb:latest

## Set Timezone

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

ADD my.cnf /etc/mysql/conf.d/my.cnf
## ADD setup.sql /etc/setup.sql

RUN chmod -R 644 /etc/mysql/conf.d/my.cnf
## RUN chmod 777 /etc/setup.sql

CMD ["mysqld"]

EXPOSE 3306
