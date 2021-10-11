FROM nginx:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    openssl certbot \
    locales bash-completion\
    zip unzip \
    vim nano \
    htop iputils-ping \
    git lsof \
    curl strace \

# Clear package lists
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
