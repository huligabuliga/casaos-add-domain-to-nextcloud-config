#!/bin/bash

# Backup the original config.php file
cp /DATA/AppData/big-bear-nextcloud/html/config/config.php /DATA/AppData/big-bear-nextcloud/html/config/config.php.bak

# Add the custom domain to the config.php file
awk '
/'trusted_domains' =>/ {
    print;
    print "  array (";
    next
}
/),/ {
    print "    " "3 => '\''nextcloud.huligabuliga.com'\'',"; # Adjust index as needed
    print;
    next
}
1' /DATA/AppData/big-bear-nextcloud/html/config/config.php.bak > /DATA/AppData/big-bear-nextcloud/html/config/config.php

# Get the path to the docker-compose.yml file
COMPOSE_FILE="/var/lib/casaos/apps/big-bear-nextcloud/docker-compose.yml"

# Apply changes using casaos-cli
casaos-cli app-management apply "big-bear-nextcloud" --file="$COMPOSE_FILE"
