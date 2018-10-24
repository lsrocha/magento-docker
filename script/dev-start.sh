#!/bin/bash
update-ca-certificates

if [ ! -z "$NGINX_UID" ]; then
    if [ -z "$NGINX_GID" ]; then
        NGINX_GID="$NGINX_UID"
    fi

    deluser nginx
    addgroup -g $NGINX_GID nginx
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx -u $NGINX_UID nginx

    if [ ! -z "$DEV_UID" ]; then
        XDEBUG_LOG="/tmp/xdebug.log"

        adduser -D -S -s /bin/bash -G nginx -u $DEV_UID dev
        su dev -c "echo \"alias mage='php -d memory_limit=4G -f /var/www/html/bin/magento'\" > /home/dev/.bashrc"

        if [ ! -f $XDEBUG_LOG ]; then
            touch $XDEBUG_LOG
        fi

        chown nginx:nginx $XDEBUG_LOG
        chmod 0664 $XDEBUG_LOG
    fi

    unset PUID
    unset PGID
fi

source /start.sh
