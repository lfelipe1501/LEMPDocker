FROM mariadb:latest

## Set Variables setup.sql

ARG MARIADB_USER
ARG USERDB=${MARIADB_USER}
ENV USERDB ${USERDB}

ARG MARIADB_PASSWORD
ARG UPWDB=${MARIADB_PASSWORD}
ENV UPWDB ${UPWDB}

ARG MARIADB_DATABASE
ARG DBUP=${MARIADB_DATABASE}
ENV DBUP ${DBUP}

## Set Timezone

ARG WORKSPACE_TIMEZONE
ARG TZ=${WORKSPACE_TIMEZONE}
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

ADD my.cnf /etc/mysql/conf.d/my.cnf

RUN chmod -R 644 /etc/mysql/conf.d/my.cnf

CMD ["mysqld"]

EXPOSE 3306
