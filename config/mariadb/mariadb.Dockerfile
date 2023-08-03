FROM mariadb:latest

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

## Set Timezone
ARG TZ=UTC
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

ADD my.cnf /etc/mysql/conf.d/my.cnf

RUN chmod -R 644 /etc/mysql/conf.d/my.cnf

CMD ["mariadbd"]

EXPOSE 3306
