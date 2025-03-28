#!/bin/bash

# default.conf.template dosyasını .env değişkenlerine göre oluştur
mv /etc/nginx/templates/default.conf /etc/nginx/sites-available/default

mkdir -p /etc/nginx/ssl

# SSL sertifikası oluştur
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
echo "Nginx: setting up ssl ...";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=TR/ST=ISTANBUL/L=SARIYER/O=42Istanbul/CN=${DOMAIN_NAME}";
echo "Nginx: ssl is set up!";
fi

# NGINX başlat
nginx -g "daemon off;"
