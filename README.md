# Magento 2 Docker

Docker container for Magento development based on [richarvey/nginx-php-fpm](https://hub.docker.com/r/richarvey/nginx-php-fpm/) image.

## Specs
- Alpine Linux 3.4.6
- PHP 7.1.12
- Nginx 1.13.7
- Magento 2.2.6

## Requirements
- Docker Compose
- Git

## Installation

```sh
$ git clone --recursive git@github.com:lsrocha/magento-docker.git
```

```sh
$ docker-compose up -d
```

The next step is to install and configure your Magento store. Check [Magento documentation](https://devdocs.magento.com/guides/v2.2/install-gde/composer.html#install-magento) for details.

By default, the server will listen to `store.local` address. You can custom it specifying `DOMAIN` environment variable on `docker-compose.yml` file.

## How to

### Execute Magento commands

```sh
$ docker exec magento-docker_web_1 magento
```

### Listen to Nginx logs

```sh
$ docker logs -f magento-docker_web_1
```

### Listen to Magento logs

```sh
$ docker exec -t magento-docker_web_1 bash -c 'tail -f /var/www/html/var/log/*.log'
```

### Debug your application

Point your client/IDE to port 9000 and enable script debugging on your browser. Extensions for this purpose can be found in [Xdebug documentation](https://xdebug.org/docs/remote). 
