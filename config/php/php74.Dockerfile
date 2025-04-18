FROM alpine:3.15

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

# Set Variables
ARG TZ\
    VPHP\
    USR_ID\
    GRP_ID
ENV TZ=${TZ}\
    VPHP=${VPHP}\
    USR_ID=${USR_ID}\
    GRP_ID=${GRP_ID}

# Create user to protect container
RUN addgroup -g $GRP_ID phpusr\
    && adduser phpusr --shell /sbin/nologin\
    --disabled-password --uid $USR_ID --ingroup phpusr

# Install php and prepare
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache nano bash vim curl wget sqlite\
    tzdata zip unzip openssl busybox-extras linux-headers\
    php${VPHP} php${VPHP}-fpm php${VPHP}-opcache php${VPHP}-pecl-xdebug php${VPHP}-simplexml\
    php${VPHP}-zlib php${VPHP}-curl php${VPHP}-session php${VPHP}-json php${VPHP}-xmlreader\
    php${VPHP}-gd php${VPHP}-exif php${VPHP}-zip php${VPHP}-mysqli supervisor\
    php${VPHP}-pdo php${VPHP}-iconv php${VPHP}-fileinfo php${VPHP}-xml php${VPHP}-mcrypt\
    php${VPHP}-common php${VPHP}-intl php${VPHP}-bcmath php${VPHP}-dom php${VPHP}-mbstring\
    php${VPHP}-pdo_mysql php${VPHP}-xmlwriter php${VPHP}-phar php${VPHP}-ctype php${VPHP}-tokenizer\
    php${VPHP}-soap php${VPHP}-sockets php${VPHP}-tidy php${VPHP}-pecl-imagick\
    php${VPHP}-pear php${VPHP}-dev gcc musl-dev make ghostscript-fonts ghostscript\
    && ln -sf /usr/bin/php${VPHP} /usr/bin/php\
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*\
    && rm -rf /tmp/{.}* /tmp/*\
    && rm -rf /var/cache/apk/*

# Installing composer
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php\
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer\
    && rm -rf composer-setup.php

# Copy EntryPoint Configuration
COPY start.sh /start.sh

# Clear package lists
RUN mkdir -p /var/www/html\
    && cat /usr/share/zoneinfo/${TZ} > /etc/localtime\
    && echo $TZ > /etc/timezone\
    && chown -R $USR_ID:$GRP_ID /var/www\
    && chown -R $USR_ID:$GRP_ID /var/log\
    && chown $USR_ID:$GRP_ID /etc/localtime\
    && chown $USR_ID:$GRP_ID /etc/timezone\
    && chown $USR_ID:$GRP_ID /start.sh\
    && chmod 777 /start.sh

EXPOSE 9000

USER phpusr
WORKDIR /var/www/html/

# Run the application
CMD ["/start.sh"]

