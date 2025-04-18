FROM mariadb:latest

LABEL maintainer="Luis Felipe Sanchez <lfelipe1501@gmail.com>"

# Set Variables
ARG USR_ID\
    GRP_ID

ENV USR_ID=${USR_ID} \
    GRP_ID=${GRP_ID}

COPY ssl/CA/ca-cert.pem /usr/local/share/ca-certificates/ca-cert.pem

# Change the mysql user to the specified UID and GID
RUN if getent group ${GRP_ID} > /dev/null 2>&1; then \
        GROUP_NAME=$(getent group ${GRP_ID} | cut -d: -f1); \
        echo "Group with ID ${GRP_ID} already exists as ${GROUP_NAME}, using it"; \
        if [ "${GROUP_NAME}" != "mysql" ]; then \
            echo "Changing mysql user to use group ${GROUP_NAME}"; \
            usermod -g ${GROUP_NAME} mysql; \
        fi; \
    else \
        echo "Changing mysql group ID to ${GRP_ID}"; \
        groupmod -g ${GRP_ID} mysql; \
    fi \
    && usermod -u ${USR_ID} mysql \
    && update-ca-certificates

USER mysql
