#!/bin/bash

# Путь к конфигурационному файлу nginx
NGINX_CONF="/etc/nginx/sites-available/testweb"

# Создать конфигурационный файл nginx
cat <<EOL | sudo tee $NGINX_CONF
server {
    listen 80;
    listen [::]:80 default_server;
    server_name khabarovsk.burstroy.ru;

    location / {
        proxy_pass http://localhost:5005;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOL

# Создать символическую ссылку в sites-enabled
sudo ln -s $NGINX_CONF /etc/nginx/sites-enabled/

# Проверить конфигурацию nginx и перезапустить его
sudo nginx -t
sudo systemctl restart nginx

echo "Конфигурация nginx для тестового сайта успешно создана и применена"
