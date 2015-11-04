#!/bin/bash
#TODO: Add DiamanteDesk installation
chown -R www-data:www-data web app/attachment app/attachments app/cache app/logs app/config/parameters.yml
apache2ctl -DFOREGROUND
