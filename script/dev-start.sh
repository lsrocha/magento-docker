#!/bin/bash
if [ ! -z "$USER_ID" ]; then
    if [ ! -z "$GROUP_ID" ]; then
        GROUP_ID="$USER_ID"
    fi

    addgroup -g $GROUP_ID dev
    adduser -D -S -s /bin/bash -G dev -u $USER_ID dev
    su dev -c "echo \"alias mage='php -d memory_limit=4G -f /var/www/html/bin/magento'\" > /home/dev/.bashrc"

    deluser nginx
    addgroup nginx
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G dev nginx

    unset PUID
    unset PGID
fi

source /start.sh
