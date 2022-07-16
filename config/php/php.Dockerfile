FROM php:7.4-fpm

## Set Timezone
ARG TZ=UTC
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies
RUN apt-get update && apt-get install -y libpng-dev zlib1g-dev libzip-dev libjpeg62-turbo-dev libfreetype6-dev locales bash-completion zip unzip jpegoptim optipng pngquant gifsicle nano apt-utils openssl git lsof libpq-dev libmagick++-dev libmagickwand-dev curl strace libwebp-dev libxpm-dev libzip-dev


# Install composer
RUN curl --silent --show-error https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Install extensions

RUN docker-php-ext-install gd intl pdo_mysql pdo_pgsql mysqli zip exif pcntl

RUN pecl install imagick
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN docker-php-ext-enable imagick

# Clear package lists
RUN apt-get clean all; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

CMD ["php-fpm"]

EXPOSE 9000
