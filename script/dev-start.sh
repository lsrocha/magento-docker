#!/bin/bash
if [ ! -z "$NGINX_UID" ]; then
    if [ -z "$NGINX_GID" ]; then
        NGINX_GID="$NGINX_UID"
    fi

    deluser nginx
    addgroup -g $NGINX_GID nginx
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx -u $NGINX_UID nginx

    if [ ! -z "$DEV_UID" ]; then
        adduser -D -S -s /bin/bash -G nginx -u $DEV_UID dev
        su dev -c "echo \"alias mage='php -d memory_limit=4G -f /var/www/html/bin/magento'\" > /home/dev/.bashrc"
    fi

    unset PUID
    unset PGID
fi

source /start.sh
