#!/bin/bash
composer dumpautoload
composer run-script post-update-cmd
chown -R www-data:www-data web app/cache
apache2ctl -DFOREGROUND