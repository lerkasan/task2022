#!/usr/bin/env bash

HTTP_HOST="localhost"
APACHE2_WWW_ROOT="/var/www"
WWW_SRC="./html/index.html"
SITES_AVAILABLE="/etc/apache2/sites-available"
CONFIG_TEMPLATE="./config/localhost.conf"

# Install Apache Httpd package
sudo apt-get update
sudo apt-get -y install apache2

# Create document root for localhost
sudo mkdir -p "${APACHE2_WWW_ROOT}/${HTTP_HOST}"
sudo chown -R "${APACHE_RUN_USER}:${APACHE_RUN_GROUP}" "${APACHE2_WWW_ROOT}/${HTTP_HOST}"
sudo chmod -R 755 "${APACHE2_WWW_ROOT}/${HTTP_HOST}"

# Copy index.html to document root
sudo cp "${WWW_SRC}" "${APACHE2_WWW_ROOT}/${HTTP_HOST}"

# Configure virtual host
sed "s/{{ http_host }}/${HTTP_HOST}/g" "${CONFIG_TEMPLATE}" | sudo tee "${SITES_AVAILABLE}/${HTTP_HOST}.conf"

# Enable site
sudo a2ensite "${HTTP_HOST}.conf"
sudo systemctl restart apache2
