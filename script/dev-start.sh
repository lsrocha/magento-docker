#!/bin/bash

export PUID="$NGINX_UID"
export PGID="$NGINX_GID"

source /start.sh

if [ ! -z "$DEV_UID" ]; then
    adduser -D -S -s /bin/bash -G nginx -u $DEV_UID dev
    su dev -c "echo \"alias mage='php -d memory_limit=4G -f /var/www/html/bin/magento'\" > /home/dev/.bashrc"
fi
