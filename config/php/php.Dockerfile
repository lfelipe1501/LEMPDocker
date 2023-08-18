ARG VPHP
FROM php:${VPHP}-fpm-alpine

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

## Set Timezone
ARG TZ=UTC
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies and extensions
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache --virtual .build-deps icu-dev nano vim zlib\
    curl busybox-extras linux-headers make autoconf libmemcached-dev\
    postgresql-dev tzdata zip unzip openssl lftp ncdu bzip2-dev krb5-dev\
    gettext gettext-dev libxml2-dev libxslt-dev libzip-dev curl-dev imagemagick-dev\
    libjpeg-turbo-dev libpng-dev libwebp-dev freetype-dev imap-dev g++\
    && docker-php-ext-install -j$(nproc)\
    bcmath bz2 calendar exif gettext\
    mysqli opcache pdo pdo_mysql\
    pgsql pdo_pgsql soap xsl\
    && docker-php-ext-configure gd --with-freetype --with-jpeg\
    && docker-php-ext-install -j$(nproc) gd\
    && PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl\
    && docker-php-ext-install -j$(nproc) imap\
    && docker-php-ext-configure intl\
    && docker-php-ext-install -j$(nproc) intl\
    && docker-php-ext-configure zip\
    && docker-php-ext-install zip\
    && pecl install memcached && docker-php-ext-enable memcached\
    && yes '' | pecl install imagick && docker-php-ext-enable imagick\
    && docker-php-source delete\
    && apk del --purge .build-deps && true\
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*\
    && rm -rf /tmp/{.}* /tmp/*\
    && rm -rf /var/cache/apk/*

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 9000

CMD ["php-fpm"]
