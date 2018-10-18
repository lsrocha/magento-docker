FROM richarvey/nginx-php-fpm:1.3.10

ENV REMOVE_FILES=0
ENV SKIP_COMPOSER=1
ENV SKIP_CHOWN=1
ENV PGID=1000
ENV PUID=1000
ENV ENABLE_XDEBUG=1
ENV ERRORS=1
ENV PHP_ERRORS_STDERR=1

ENV DOMAIN=store.local
ENV WEBROOT=/var/www/html
ENV PATH="${PATH}:${WEBROOT}/bin:${WEBROOT}/vendor/bin"

EXPOSE 80/tcp
EXPOSE 9000/tcp

RUN docker-php-ext-configure bcmath
RUN docker-php-ext-install bcmath

COPY magento/nginx.conf.sample /etc/nginx/magento.conf.sample
COPY config/default.conf /etc/nginx/sites-available/default.conf
