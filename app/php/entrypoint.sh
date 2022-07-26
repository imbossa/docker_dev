#!/bin/bash

# restart cron
service cron restart

php-fpm -D
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf