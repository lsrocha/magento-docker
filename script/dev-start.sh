#!/bin/bash
update-ca-certificates

if [ ! -z "$NGINX_UID" ]; then
    if [ -z "$NGINX_GID" ]; then
        NGINX_GID="$NGINX_UID"
    fi

    # Updating 'nginx' group ID
    deluser nginx
    addgroup -g $NGINX_GID nginx
    adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx -u $NGINX_UID nginx

    if [ ! -z "$DEV_UID" ]; then
        XDEBUG_LOG="/tmp/xdebug.log"

        # Creating 'dev' user
        adduser -D -S -s /bin/bash -G nginx -u $DEV_UID dev

        # Creating bash aliases
        su dev -c 'echo alias mage=\"php -d memory_limit=4G -f /var/www/html/bin/magento\" >> /home/dev/.bashrc'
        su dev -c 'echo alias ssh-start=\"eval \`ssh-agent -s\`\" >> /home/dev/.bashrc'

        if [ ! -f $XDEBUG_LOG ]; then
            touch $XDEBUG_LOG
        fi

        # Changing Xdebug log permissions
        chown nginx:nginx $XDEBUG_LOG
        chmod 0664 $XDEBUG_LOG
    fi

    unset PUID
    unset PGID
fi

source /start.sh
