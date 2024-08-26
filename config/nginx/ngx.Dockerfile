FROM alpine:latest

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

## Set Timezone
ARG TZ

# Set Variables
ARG ARCH_TYPE
ENV TZ=${TZ}\
    ARCH_TYPE=${ARCH_TYPE}

# Create user to protect container
RUN addgroup -g 1000 nginx\
    && adduser nginx --shell /sbin/nologin\
    --disabled-password --uid 1000 --ingroup nginx

# Install php and prepare
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache nano bash wget nginx \
    tzdata zip unzip openssl nginx-mod-http-xslt-filter \
    vim curl nginx-mod-http-fancyindex \
    && NGINXUI_VERSION=$(curl -s https://api.github.com/repos/0xJacky/nginx-ui/releases/latest|grep tag_name | cut -d '"' -f 4|sed 's/v//g' | sed s/"release-"//)\
    && wget https://github.com/0xJacky/nginx-ui/releases/download/v${NGINXUI_VERSION}/nginx-ui-${ARCH_TYPE}.tar.gz\
    && tar -xvzf nginx-ui-${ARCH_TYPE}.tar.gz && rm -rf *.md && chmod 777 nginx-ui\
    && mv nginx-ui /bin && rm -rf nginx-ui-${ARCH_TYPE}.tar.gz && mkdir -p /etc/nginx-ui && ln -sf /etc/nginx-ui /app \
    && mkdir -p /var/www/html/logs \
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/*\
    && rm -rf /tmp/{.}* /tmp/*\
    && rm -rf /var/cache/apk/*

COPY nginx.zip /etc/nginx.zip

# Copy EntryPoint Configuration
COPY start.sh /start.sh
COPY app.ini /etc/nginx-ui/app.ini

# Clear package lists
RUN rm -rf /etc/nginx && unzip -o /etc/nginx.zip -d /etc/ \
    && unzip -o /etc/nginx.zip -d /usr/etc/ \
    && cat /usr/share/zoneinfo/${TZ} > /etc/localtime \
    && echo $TZ > /etc/timezone \
    && chown -R 1000:1000 /etc/nginx \
    && chown -R 1000:1000 /usr/etc/nginx \
    && chown -R 1000:1000 /etc/nginx-ui \
    && chown -R 1000:1000 /var/run \
    && chmod -R 777 /var/run \
    && chmod -R 777 /run \
    && chown -R 1000:1000 /run \
    && chown -R 1000:1000 /var/cache \
    && chown -R 1000:1000 /var/log/nginx \
    && rm -rf /var/log/nginx \
	&& ln -sf /var/www/html/logs /var/log/nginx \
    && chown 1000:1000 /etc/localtime \
    && chown 1000:1000 /etc/timezone \
    && chown -R 1000:1000 /var/www \
    && chmod 777 /start.sh \
    && chown 1000:1000 /bin/nginx-ui \
    && chown 1000:1000 /start.sh

EXPOSE 80 81 443 9000

USER nginx
WORKDIR /app

# Run the application
CMD ["/start.sh"]