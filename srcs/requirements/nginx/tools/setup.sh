#!/bin/bash

# Ortam değişkenlerini yükle
export $(grep -v '^#' /tmp/env_vars | xargs)

# default.conf.template dosyasını .env değişkenlerine göre oluştur
envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/sites-available/gotunc.42.fr

# SSL sertifikası oluştur

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
echo "Nginx: setting up ssl ...";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=TR/ST=ISTANBUL/L=SARIYER/O=42Istanbul/CN=${DOMAIN_NAME}";
echo "Nginx: ssl is set up!";
fi


ln -s /etc/nginx/sites-available/gotunc.42.fr /etc/nginx/sites-enabled/gotunc.42.fr

# NGINX başlat
nginx -g "daemon off;"
