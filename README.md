# Docker Compose LEMP stack with Latest Versions

This repository contains a little `docker-compose` configuration to start a `LEMP (Linux, Nginx, MariaDB, PHP)` stack.

## Details

The following versions are used.

* PHP latest avaliable (FPM) - With MySQLi driver
* Nginx latest avaliable
* MariaDB latest avaliable
* phpMyAdmin 5 version Latest - Access with custom Port in .env

The versions used in these containers are the latest available for each official container of the indicated service, if you want to use a different or specific version you can edit the dockerfile files of each container in the `config` folder or if you want to add new commands within each container, extensions, services, etc., you can edit each dockerfile of each of them to customize it according to your needs.

## Configuration

The __NGINX__ configuration can be found in `config/nginx/`.

The `app` folder is a static path and you can upload the files of your applications in real time to be deployed and displayed by the nginx and php service.
You can create multiple virtualhost inside `nginx.conf` file or you can create separate files as you like, and adjust the path of your applications remember `/var/www/html` is point to `app` folder, so you have to play with these paths to configure your web applications correctly.

The __PHP__ configuration can be found in `config/php/`.

The __MariaDB__ configuration can be found in `config/mariadb/`.

The __phpMyAdmin__ configuration can be found in `docker-compose.yml` at the end the file.

You can also set the following environment variables, for example in the included `.env` file:

| Key | Description |
|-----|-------------|
|APP_NAME|The name used when creating a container.|
|WORKSPACE_TIMEZONE|The timezone used when creating a db container.|
|PMA_PPORT|The phpMyAdmin port for access.|
|MYSQL_ROOT_PASSWORD|The MySQL root password used when creating the db container.|
|MARIADB_DATABASE|The MySQL database used when creating the db container.|
|MARIADB_USER|The MySQL user other than root used when creating the db container.|
|MARIADB_PASSWORD|The MySQL normal user password used when creating the db container.|
|DATA_PATH_HOST|The path used when creating a db container to store the database data in a way accessible to the host server.|

*If it is run in a windows dockerized environment with WLS2, it is NOT recommended to run on the windows desktop or in your windows system example: `/mnt/c/Users/lfelipe/Desktop/LEMPDocker/`, the good way is copy or clone the project inside the linux wls2 system preferably in the `HOME` folder of your user, because windows has problems with the partitions mounted within the linux subsystem example: `/mnt/c/Users/lfelipe/Desktop` it is a bad path and can lead to problems with docker*

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

### Contact / Social Media

*Get the latest News about Web Development, Open Source, Tooling, Server & Security*

[![Twitter](https://github.frapsoft.com/social/twitter.png)](https://twitter.com/lfelipe1501)
[![Facebook](https://github.frapsoft.com/social/facebook.png)](https://www.facebook.com/lfelipe1501)
[![Github](https://github.frapsoft.com/social/github.png)](https://github.com/lfelipe1501)

### Development by

Developer / Author: [Luis Felipe Sánchez](https://github.com/lfelipe1501)
Company: [lfsystems](https://www.lfsystems.com.co)

