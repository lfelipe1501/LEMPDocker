FROM alpine:latest

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

# Set Variables
ARG TZ\
    ARCH_TYPE\
    USR_ID\
    GRP_ID
ENV TZ=${TZ}\
    ARCH_TYPE=${ARCH_TYPE}\
    USR_ID=${USR_ID}\
    GRP_ID=${GRP_ID}

# Create user to protect container
RUN addgroup -g $GRP_ID nginx\
    && adduser nginx --shell /sbin/nologin\
    --disabled-password --uid $USR_ID --ingroup nginx

# Install php and prepare
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache nano bash wget nginx openrc\
    tzdata zip unzip openssl nginx-mod-http-xslt-filter\
    vim curl nginx-mod-http-fancyindex\
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
    && mkdir -p /usr/etc/nginx-ui \
    && cp /etc/nginx-ui/app.ini /usr/etc/nginx-ui/ \
    && cat /usr/share/zoneinfo/${TZ} > /etc/localtime \
    && echo $TZ > /etc/timezone \
    && chown -R $USR_ID:$GRP_ID /etc/nginx \
    && chown -R $USR_ID:$GRP_ID /usr/etc/nginx* \
    && chown -R $USR_ID:$GRP_ID /etc/nginx-ui \
    && chown -R $USR_ID:$GRP_ID /var/run \
    && chmod -R 777 /var/run \
    && chmod -R 777 /run \
    && chown -R $USR_ID:$GRP_ID /run \
    && chown -R $USR_ID:$GRP_ID /var/cache \
    && chown -R $USR_ID:$GRP_ID /var/log/nginx \
    && rm -rf /var/log/nginx \
    && ln -sf /var/www/html/logs /var/log/nginx \
    && chown -h $USR_ID:$GRP_ID /var/log/nginx \
    && chown $USR_ID:$GRP_ID /etc/localtime \
    && chown $USR_ID:$GRP_ID /etc/timezone \
    && chown -R $USR_ID:$GRP_ID /var/www \
    && chmod 777 /start.sh \
    && chown $USR_ID:$GRP_ID /bin/nginx-ui \
    && chown $USR_ID:$GRP_ID /start.sh

EXPOSE 80 81 443 9000

USER nginx
WORKDIR /var/www/html

# Run the application
CMD ["/start.sh"]
