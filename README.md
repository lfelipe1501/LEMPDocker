# Docker Compose LEMP stack

This repository contains a `docker compose` configuration to start a `LEMP (Linux, Nginx, MariaDB, PHP)` stack.

## Details

The following versions are used:

* PHP latest available version (FPM) - With MySQLi driver
* Nginx latest available version with [NGINX-UI DASHBOARD](https://nginxui.com/)
* MariaDB latest available version with SSL support
* phpMyAdmin latest version - Access with customized port in .env

For the Nginx and PHP containers, a Dockerfile is used for each one, based on ALPINE as the base image and adjusted according to security best practices and configuration for each of these services.

The versions used in these containers are the latest available for each official package of the indicated service. If you want to use a different or specific version, you can edit the Dockerfile of each container in the `config` folder, or if you want to add new commands inside each container, extensions, services, etc., you can edit each Dockerfile to customize it according to your needs.

For the MariaDB container, a custom Dockerfile is used, with the base image adjusted according to security best practices and optimized configuration.

The phpMyAdmin installation is created in the startup script of the PHP container as an optional feature. If you don't want it, you should remove the `pma` folder located in the app folder; otherwise, the latest stable version available is always installed and you can edit the configuration in the pma folder located in app.

## Configuration

The __NGINX__ configuration is in `data/nginx/`.

The `app` folder is a static path and you can upload your application files in real-time to be deployed and displayed by the Nginx and PHP services.
You can create multiple virtualhosts within `data/nginx/sites-available/` in separate `.conf` files if desired. After this, activate them from the Nginx-UI dashboard through port 81 or by connecting to the container and creating symbolic links to the files in the Nginx sites-enabled folder.

The __PHP__ configuration is in `config/php/`.

You can set the desired PHP version from the .env file for the versions currently supported by the PHP group, for example 82, 83, or 84.

If you need an older version, for example 7.4 which is no longer supported, you must set the version in the .env file and also modify the `compose.yml` file to set the Dockerfile for the respective version found in the `config/php` folder, where the extensions and Alpine that support that version are established.

The __MARIADB__ configuration is in `config/mariadb/`.

The __MariaDB__ configuration file my.cnf is in `config/mariadb/`.

The __phpMyAdmin__ configuration is in `app/pma/config.inc.php`.

You can also set the following environment variables in the included `.env` file:

| Key | Description |
|-----|-------------|
|APP_NAME|The name used when creating a container.|
|USR|Set user ID for the MariaDB container or for any container.|
|GRP|Set group ID for the MariaDB container or for any container.|
|ARCH_TYPE|Set the architecture for the Nginx-UI package (x86_64 or arm).|
|NGXUI_PORT|Set the access port for Nginx-UI.|
|WORKSPACE_TIMEZONE|The timezone used when creating a database container.|
|PMA_PORT|The access port for phpMyAdmin.|
|PMASSL_PORT|The SSL access port for phpMyAdmin.|
|VERSION_PHP|Version for the PHP container.|
|MYSQL_ROOT_PASSWORD|The MySQL root password used when creating the database container.|
|MARIADB_DATABASE|The MySQL database used when creating the database container.|
|MARIADB_USER|The MySQL user other than root used when creating the database container.|
|MARIADB_PASSWORD|The normal MySQL user password used when creating the database container.|
|MARIADB_PORT|The port to access MariaDB from the host.|
|DATA_PATH_HOST|The path used when creating a database container to store the database data in a way that is accessible to the host server.|

> [!CAUTION]
> _**For WSL users**: If running in a Windows dockerized environment with WLS2,
> it is NOT recommended to run it on the Windows desktop or Windows system, for example: `/mnt/c/Users/lfelipe/Desktop/LEMPDocker/`,
> best practice is to copy or clone the project inside the WLS2 Linux system, preferably in the `HOME` folder of your user,
> because Windows has issues with mounted partitions inside the Linux subsystem, for example: `/mnt/c/Users/lfelipe/Desktop`
> is a poor path and can cause problems with docker._

## Usage

To use it, simply follow these steps:

##### Clone this repository.

Clone this repository with the following command:
```bash
git clone https://github.com/lfelipe1501/LEMPDocker.git
```

#### Start the server.

> [!important]
> _**BEFORE RUNNING** the project, **YOU MUST** edit the variables in the `.env` file
> before starting the environment to adjust the configuration according to your preferences._

Start the server using the following command inside the directory you just cloned:
```console
docker compose up -d
```

## Restart containers

If you make changes to the PHP and Nginx configuration files (ini, conf, etc.), you need to restart each container to apply these changes, with the respective commands:

Where `{CONTAINER_NAME}` is one of:

* `{APP_NAME}-php`
* `{APP_NAME}-nginx`
* `{APP_NAME}-mariadb`

`docker restart {CONTAINER_NAME}`

> example: `docker restart lfsys-nginx`

## Access the containers

You can use the following command to access a container:

Where `{CONTAINER_NAME}` is one of:

* `{APP_NAME}-php`
* `{APP_NAME}-nginx`
* `{APP_NAME}-mariadb`

`docker exec -ti {CONTAINER_NAME} bash`

> example: `docker exec -ti lfsys-php bash`

#### Stop the server.

Stop the server using the following command inside the directory you cloned:
```console
docker compose down
```

### Contact / Social Media

*Get the latest news about Web Development, Open Source, Tools, Servers, and Security*

[![Twitter](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/twitter.svg)](https://twitter.com/lfelipe1501)
[![Facebook](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/facebook.svg)](https://www.facebook.com/lfelipe1501)
[![Github](https://raw.githubusercontent.com/lfelipe1501/lfelipe-projects/master/icons/filled/github.svg)](https://github.com/lfelipe1501)

### Developed by

Developer / Author: [Luis Felipe Sanchez](https://github.com/lfelipe1501)
Company: [lfsystems](https://www.lfsystems.com.co)

