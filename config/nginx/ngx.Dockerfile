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
RUN if getent group ${GRP_ID} > /dev/null 2>&1; then \
        GROUP_NAME=$(getent group ${GRP_ID} | cut -d: -f1); \
        echo "Group with ID ${GRP_ID} already exists as ${GROUP_NAME}, using it"; \
    else \
        echo "Creating new group nginx with ID ${GRP_ID}"; \
        addgroup -g ${GRP_ID} nginx; \
    fi \
    && if getent group ${GRP_ID} > /dev/null 2>&1; then \
        GROUP_NAME=$(getent group ${GRP_ID} | cut -d: -f1); \
        adduser nginx --shell /sbin/nologin --disabled-password --uid ${USR_ID} --ingroup ${GROUP_NAME}; \
    else \
        echo "Error: Group with ID ${GRP_ID} not found. This should not happen."; \
        exit 1; \
    fi

# Install php and prepare
RUN apk update && apk upgrade --available && sync\
    && apk add --no-cache nano bash wget nginx openrc\
    tzdata zip unzip openssl nginx-mod-http-xslt-filter\
    vim curl nginx-mod-http-fancyindex nginx-mod-stream\
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
    && GROUP_NAME=$(getent group ${GRP_ID} | cut -d: -f1) \
    && chown -R ${USR_ID}:${GROUP_NAME} /etc/nginx \
    && chown -R ${USR_ID}:${GROUP_NAME} /usr/etc/nginx* \
    && chown -R ${USR_ID}:${GROUP_NAME} /etc/nginx-ui \
    && chown -R ${USR_ID}:${GROUP_NAME} /var/run \
    && chmod -R 777 /var/run \
    && chmod -R 777 /run \
    && chown -R ${USR_ID}:${GROUP_NAME} /run \
    && chown -R ${USR_ID}:${GROUP_NAME} /var/cache \
    && chown -R ${USR_ID}:${GROUP_NAME} /var/log/nginx \
    && rm -rf /var/log/nginx \
    && ln -sf /var/www/html/logs /var/log/nginx \
    && chown -h ${USR_ID}:${GROUP_NAME} /var/log/nginx \
    && chown ${USR_ID}:${GROUP_NAME} /etc/localtime \
    && chown ${USR_ID}:${GROUP_NAME} /etc/timezone \
    && chown -R ${USR_ID}:${GROUP_NAME} /var/www \
    && chmod 777 /start.sh \
    && chown ${USR_ID}:${GROUP_NAME} /bin/nginx-ui \
    && chown ${USR_ID}:${GROUP_NAME} /start.sh

EXPOSE 80 81 443 9000

USER nginx
WORKDIR /var/www/html

# Run the application
CMD ["/start.sh"]
