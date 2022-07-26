FROM nginx:latest

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

# Install dependencies
RUN apt-get update && apt-get install -y openssl locales bash-completion zip unzip vim nano

# Clear package lists
RUN apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

## Set Timezone
ARG TZ=UTC
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 644 /etc/nginx/nginx.conf