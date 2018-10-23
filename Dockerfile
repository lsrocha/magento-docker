FROM richarvey/nginx-php-fpm:1.3.10

ENV REMOVE_FILES=0
ENV SKIP_COMPOSER=1
ENV SKIP_CHOWN=1

ENV ENABLE_XDEBUG=1
ENV ERRORS=1
ENV PHP_ERRORS_STDERR=1

RUN docker-php-ext-configure bcmath
RUN docker-php-ext-install bcmath

ADD script/dev-start.sh /dev-start.sh

CMD ["/dev-start.sh"]
