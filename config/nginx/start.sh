#!/bin/sh

# Time zone set according to the country set in the .env file
echo ""
echo "Time zone update to: " $TZ
cat /usr/share/zoneinfo/$TZ > /etc/localtime
echo ""
echo $TZ > /etc/timezone

if [ -z "$(ls /etc/nginx)" ]; then
    echo ""
    echo "Initializing Nginx config dir"
    cp -rp /usr/etc/nginx/* /etc/nginx/
    echo ""
    echo "Initialed Nginx config dir"
    echo ""
fi

if [ -z "$(ls /etc/nginx-ui)" ]; then
    echo ""
    echo "Initializing UI config dir"
    cp -rp /usr/etc/nginx-ui/* /etc/nginx-ui/
    echo ""
    echo "Initialed UI config dir"
    echo ""
fi

nginx &
nginx-ui --config /etc/nginx-ui/app.ini
