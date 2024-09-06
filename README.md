# Docker Compose LEMP stack

This repository contains a little `docker compose` configuration to start a `LEMP (Linux, Nginx, MariaDB, PHP)` stack.

## Details

The following versions are used.

* PHP latest avaliable (FPM) - With MySQLi driver
* Nginx latest avaliable with [NGINX-UI DASHBOARD](https://nginxui.com/)
* MariaDB latest avaliable
* phpMyAdmin Latest Version - Access with custom Port in .env

For the nginx and php containers, a Dockerfile is used for each one, where ALPINE is used as a base image and is adjusted according to the best security and configuration practices for each of these two services.

The versions used in these containers are the latest available for each official package of the indicated service, if you want to use a different or specific version you can edit the dockerfile files of each container in the `config` folder or if you want to add new commands within each container, extensions, services, etc., you can edit each dockerfile of each of them to customize it according to your needs.

MariaDB container use the official DockerHub containers so if you need something specific, you can use the official documentation of these containers and adjust it in the docker-compose.yml

The phpMyAdmin installation was created in the php container startup script as an optional feature, if you do not want it you must delete the pma folder located in app, otherwise the latest stable version available is always installed and you can edit the configuration in the pma folder located in app.

## Configuration

The __NGINX__ configuration can be found in `data/nginx/`.

The `app` folder is a static path and you can upload the files of your applications in real time to be deployed and displayed by the nginx and php service.
You can create multiple virtualhost inside `data/nginx/sites-avaliable/` in separate files `.conf` if you want, after this, activate them from the nginx-ui dashboard through port 81 or by connecting to the container and creating static links to the files in the nginx sites-enabled folder..

The __PHP__ configuration can be found in `config/php/`.

You can set the desired php version from the .env file for the versions currently supported by the php group, for example 8, 81 or 82

If you need an older version, for example 7.4 which is no longer supported, you must set the version in the .env and also modify the `docker-compose.yml` file to set the dockerfile for the respective version which is located in the `config/php` folder where the extensions and alpine that supports the version are set.

The __MariaDB__ configuration file my.cnf can be found in `config/mariadb/`.

The __phpMyAdmin__ configuration can be found in `app/pma/config.inc.php`.

You can also set the following environment variables, for example in the included `.env` file:

| Key | Description |
|-----|-------------|
|APP_NAME|The name used when creating a container.|
|USR|Set User ID for mariadb container o for any container.|
|GRP|Set Group ID for mariadb container o for any container.|
|ARCH_TYPE|Set the architecture of the nginx-ui package (x86_64 or arm).|
|NGXUI_PORT|Set nginx-ui port for Access.|
|WORKSPACE_TIMEZONE|The timezone used when creating a db container.|
|PMA_PORT|The phpMyAdmin port for access.|
|PMASSL_PORT|The phpMyAdmin port for SSL access.|
|VERSION_PHP|Version for the php container.|
|MYSQL_ROOT_PASSWORD|The MySQL root password used when creating the db container.|
|MARIADB_DATABASE|The MySQL database used when creating the db container.|
|MARIADB_USER|The MySQL user other than root used when creating the db container.|
|MARIADB_PASSWORD|The MySQL normal user password used when creating the db container.|
|DATA_PATH_HOST|The path used when creating a db container to store the database data in a way accessible to the host server.|

> [!CAUTION]
> _**For WSL users**: If it is run in a windows dockerized environment with WLS2,
> it is NOT recommended to run on the windows desktop or in your windows system example: `/mnt/c/Users/lfelipe/Desktop/LEMPDocker/`,
> the good way is copy or clone the project inside the linux wls2 system preferably in the `HOME` folder of your user,
> because windows has problems with the partitions mounted within the linux subsystem example: `/mnt/c/Users/lfelipe/Desktop`
> it is a bad path and can lead to problems with docker_

## Usage

To use it, simply follow the following steps:

##### Clone this repository.

Clone this repository with the following command:
```bash
git clone https://github.com/lfelipe1501/LEMPDocker.git
```

##### Start the server.

Start the server using the following command inside the directory you just cloned: `docker compose up -d`.

*Remember to edit the variables in the `.env` file before starting the environment to adjust the formula to your preferences*

## Restart the containers

If you make changes to the php and nginx config files (ini, conf, etc) you must restart each container to apply these changes, with the respective commands:

Where `{CONTAINER_NAME}` is one of:

* `{APP_NAME}-php`
* `{APP_NAME}-nginx`

`docker restart {CONTAINER_NAME}`

> example: `docker restart lfsys-nginx`

## Entering the containers

You can use the following command to enter a container:

Where `{CONTAINER_NAME}` is one of:

* `{APP_NAME}-php`
* `{APP_NAME}-nginx`
* `{APP_NAME}-mariadb`

`docker exec -ti {CONTAINER_NAME} bash`

> example: `docker exec -ti lfsys-php bash`

##### Stop the server.

Stop the server using the following command inside the directory you just cloned: `docker compose down`.

### Contact / Social Media

*Get the latest News about Web Development, Open Source, Tooling, Server & Security*

[![Twitter](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/twitter.svg)](https://twitter.com/lfelipe1501)
[![Facebook](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/facebook.svg)](https://www.facebook.com/lfelipe1501)
[![Github](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/github.svg)](https://github.com/lfelipe1501)

### Development by

Developer / Author: [Luis Felipe Sanchez](https://github.com/lfelipe1501)
Company: [lfsystems](https://www.lfsystems.com.co)

