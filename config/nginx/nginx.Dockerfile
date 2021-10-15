FROM nginx:latest

# Install dependencies
RUN apt-get update && apt-get install -y openssl locales bash-completion zip unzip vim nano

# Clear package lists
RUN apt-get clean all; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

## Set Timezone
ARG TZ=UTC
ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD nginx.conf /etc/nginx/nginx.conf
RUN chmod -R 644 /etc/nginx/nginx.conf