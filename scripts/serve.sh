#!/usr/bin/env bash

block="server {
    listen 80;
    server_name   $1;
    passenger_enabled on;
    passenger_app_env development;
    root          $2;

    access_log off;
    error_log  /var/log/nginx/$1-error.log error;

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   html;
    }
}
"

echo "$block" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
service nginx restart