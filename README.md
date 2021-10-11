# Docker Compose LEMP stack with Latest Versions

This repository contains a little `docker-compose` configuration to start a `LEMP (Linux, Nginx, MariaDB, PHP)` stack.

## Details

The following versions are used.

* PHP latest avaliable (FPM) - With MySQLi driver
* Nginx latest avaliable
* MariaDB latest avaliable

The versions used in these containers are the latest available for each official container of the indicated service, if you want to use a different or specific version you can edit the dockerfile files of each container in the `config` folder or if you want to add new commands within each container, extensions, services, etc., you can edit each dockerfile of each of them to customize it according to your needs.

## Configuration

The Nginx configuration can be found in `config/nginx/`.

The PHP configuration can be found in `config/php/`.

The MariaDB configuration can be found in `config/mariadb/`.

You can also set the following environment variables, for example in the included `.env` file:

| Key | Description |
|-----|-------------|
|APP_NAME|The name used when creating a container.|
|WORKSPACE_TIMEZONE|The timezone used when creating a db container.|
|MYSQL_ROOT_PASSWORD|The MySQL root password used when creating the db container.|
|MARIADB_DATABASE|The MySQL database used when creating the db container.|
|MARIADB_USER|The MySQL user other than root used when creating the db container.|
|MARIADB_PASSWORD|The MySQL normal user password used when creating the db container.|
|DATA_PATH_HOST|The path used when creating a db container to store the database data in a way accessible to the host server.|

*If it is run in a windows dockerized environment with WLS2, the mysql data path may run with error, in this case disable the static path or create the data manually after it has been deployed.*

## Usage

To use it, simply follow the following steps:

##### Clone this repository.

Clone this repository with the following command: `git clone https://github.com/lfelipe1501/LEMPDocker.git`.

##### Start the server.

Start the server using the following command inside the directory you just cloned: `docker-compose up -d`.

## Entering the containers

You can use the following command to enter a container:

Where `{CONTAINER_NAME}` is one of:

`docker exec -ti {CONTAINER_NAME} /bin/bash`

* `{APP_NAME}-php`
* `{APP_NAME}-nginx`
* `{APP_NAME}-mariadb`
