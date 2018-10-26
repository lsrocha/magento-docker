# Magento 2 Docker

Docker container for Magento development based on [richarvey/nginx-php-fpm](https://hub.docker.com/r/richarvey/nginx-php-fpm/) image.

## Specs
- Alpine Linux 3.4.6
- PHP 7.1.12
- Nginx 1.13.7
- MariaDB 10.2
- Redis 3.2

## Requirements
- Git
- Docker

## Installation

1. Clone the repository

    ```sh
    $ git clone git@github.com:lsrocha/magento-docker.git
    $ cd magento-docker
    ```

2. Configure your services

    This project provides you sample config files. After cloning it, copy them and make the necessary changes.

    ```sh
    $ cp docker-compose.yml.sample docker-compose.yml
    $ cp config/nginx/default.conf.sample config/nginx/default.conf
    ```

3. Import your code

    Import your Magento project into the resultant directory. Feel free to follow the best way for you, but be sure your project directory is called `magento`. For example, you can run: `git clone [...] magento`, `mv [...] magento` or even `composer create-project [...] magento` (following [Magento installation doc](https://devdocs.magento.com/guides/v2.2/install-gde/composer.html)).

    Inside Magento root directory, don't forget to copy `nginx.conf.sample` file to `nginx.conf`.

4. Create docker containers

    ```sh
    $ docker-compose up -d
    ```

Now your store is available at `http://store.local`.

## How to

### Access container terminal

```sh
$ docker exec -it magento-docker_web_1 su dev -c bash
```

### Listen to Nginx logs

```sh
$ docker logs -f magento-docker_web_1
```

### Debug your application

Point your client/IDE to port 9000 and enable script debugging on your browser. Extensions for this purpose can be found in [Xdebug documentation](https://xdebug.org/docs/remote).

## Configure multiple stores/websites

1. Map your stores in `config/nginx/default.conf`

    ```nginx
    map $http_host $MAGE_RUN_CODE {
        store.local default;
        storeview.local store1;
    }

    server {
        [...]
        server_name store.local storeview.local;
        [...]
        set $MAGE_RUN_TYPE store; # or website
        [...]
    }
    ```

2. Edit your `magento/.../nginx.conf`

    ```nginx
    location ~ (index|get|static|report|404|503|health_check)\.php$ {
        [...]
        fastcgi_param  MAGE_RUN_TYPE $MAGE_RUN_TYPE;
        fastcgi_param  MAGE_RUN_CODE $MAGE_RUN_CODE;
        include        fastcgi_params;
    }
    ```
