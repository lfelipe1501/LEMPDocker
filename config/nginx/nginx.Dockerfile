FROM nginx:latest

# Install dependencies
RUN apt update && apt install -y build-essential openssl certbot locales bash-completion zip unzip vim nano htop iputils-ping git lsof curl strace

# Clear package lists
RUN apt clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
