#!/bin/bash

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=$C/ST=$ST/L=$L/O=$O/CN=$DOMAIN_NAME";
echo "SSL certificate and key successfully created.";
fi
exec "$@"
