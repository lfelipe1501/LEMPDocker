FROM mariadb:latest

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

# Set Variables
ARG USR_ID\
    GRP_ID

ENV USR_ID=${USR_ID} \
    GRP_ID=${GRP_ID}

COPY ssl/CA/ca-cert.pem /usr/local/share/ca-certificates/ca-cert.pem

# Change the mysql user to the specified UID and GID
RUN groupmod -g ${GRP_ID} mysql && \
    usermod -u ${USR_ID} mysql && \
    update-ca-certificates

USER mysql
