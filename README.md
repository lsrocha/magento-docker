# Magento 2 Docker

Docker container for Magento development based on [richarvey/nginx-php-fpm](https://hub.docker.com/r/richarvey/nginx-php-fpm/) image.

## Specs
- Alpine Linux 3.4.6
- PHP 7.1.12
- Nginx 1.13.7
- MariaDB 10.2

## Requirements
- Git
- Docker Compose

## Installation

1. Clone the repository

    ```sh
    $ git clone git@github.com:lsrocha/magento-docker.git
    $ cd magento-docker
    ```

2. Create a shared database volume (if it doesn't exist)

    ```sh
    $ docker volume create mariadb
    ```

3. Prepare your Docker Compose file

    This project provides you a sample Docker Compose file. After cloning it, copy `docker-compose.yml.sample` to `docker-compose.yml` and make the necessary changes.

4. Import your code

    Import your Magento project into the resultant directory. Feel free to follow the best way for you, but be sure your project directory is called `magento`. For example, you can run: `git clone [...] magento`, `mv [...] magento` or even `composer create-project [...] magento` (following [Magento installation doc](https://devdocs.magento.com/guides/v2.2/install-gde/composer.html)).

5. Create docker containers

    ```sh
    $ docker-compose up -d
    ```

Now your store is available at `http://store.local`.

## How to

### Listen to Nginx logs

```sh
$ docker logs -f magento-docker_web_1
```

### Debug your application

Point your client/IDE to port 9000 and enable script debugging on your browser. Extensions for this purpose can be found in [Xdebug documentation](https://xdebug.org/docs/remote). 
