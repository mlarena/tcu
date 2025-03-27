#!/bin/bash

# Создание конфигурационного файла для Nginx
sudo bash -c 'cat > /etc/nginx/sites-available/burstroyweb' <<EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name test.burstroy.ru;

    location / {
        proxy_pass http://localhost:5000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    # Поддержка WebSocket для Blazor Server
    location /_blazor {
        proxy_pass http://localhost:5000/_blazor;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

# Удаление старой символической ссылки, если она существует
sudo rm -f /etc/nginx/sites-enabled/burstroyweb

# Создание символической ссылки
sudo ln -s /etc/nginx/sites-available/burstroyweb /etc/nginx/sites-enabled/

# Проверка конфигурации Nginx и перезапуск
if sudo nginx -t; then
    sudo systemctl restart nginx
    echo "Blazor приложение успешно настроено и запущено на Nginx."
else
    echo "Ошибка в конфигурации Nginx. Проверьте файл /etc/nginx/sites-available/burstroyweb."
    exit 1
fi