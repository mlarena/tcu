#!/bin/bash

# Создание конфигурационного файла для Nginx
sudo bash -c 'cat > /etc/nginx/sites-available/burstroyweb' <<'EOF'
server {
    listen 80 default_server;
    server_name 87.226.220.242:8082;

    access_log /var/log/nginx/burstroyweb_access.log;
    error_log /var/log/nginx/burstroyweb_error.log;

#    location / {
#        proxy_pass http://localhost:5000;
#        proxy_http_version 1.1;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection "Upgrade";
#        proxy_set_header Host $host;
#        proxy_cache_bypass $http_upgrade;
#        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#        proxy_set_header X-Forwarded-Proto $scheme;
#    }

#    location /ws/ {
#        proxy_pass http://localhost:5000;
#        proxy_http_version 1.1;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection "Upgrade";
#        proxy_set_header Host $host;
#        proxy_cache_bypass $http_upgrade;
#        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
#        proxy_set_header X-Forwarded-Proto $scheme;
#    }
    location / {
        proxy_pass         http://localhost:5000;
        proxy_http_version 1.1;

        proxy_set_header   Upgrade $http_upgrade;
        proxy_set_header   Connection "upgrade";
        proxy_set_header   Host $host;

        proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto $scheme;

        proxy_read_timeout 120s;
        proxy_send_timeout 120s;
    }

}
EOF

# Создание символической ссылки на конфигурационный файл
sudo ln -s /etc/nginx/sites-available/burstroyweb /etc/nginx/sites-enabled/

# Проверка конфигурации Nginx
sudo nginx -t

# Перезапуск Nginx
sudo systemctl restart nginx

echo "Blazor приложение успешно настроено и запущено на Nginx."
