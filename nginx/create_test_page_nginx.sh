#!/bin/bash

# Создаем каталог для HTML страницы, если он не существует
sudo mkdir -p /burstroy/testweb

# Создаем простую HTML страницу
sudo bash -c 'cat > /burstroy/testweb/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test Web Page</title>
</head>
<body>
    <h1>Welcome to My Test Web Page!</h1>
    <p>This is a simple HTML page served by Nginx.</p>
</body>
</html>
EOF'

# Обновляем список пакетов и устанавливаем Nginx
sudo apt update
sudo apt install -y nginx

# Создаем конфигурационный файл для нашего сайта
sudo bash -c 'cat > /etc/nginx/sites-available/testweb <<EOF
server {
    listen 80;
    server_name _;

    root /burstroy/testweb;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF'

# Создаем символическую ссылку на конфигурационный файл в sites-enabled
sudo ln -s /etc/nginx/sites-available/testweb /etc/nginx/sites-enabled/

# Удаляем стандартный конфигурационный файл
sudo rm /etc/nginx/sites-enabled/default

# Проверяем конфигурацию Nginx на наличие ошибок
sudo nginx -t

# Перезапускаем Nginx для применения изменений
sudo systemctl restart nginx

echo "Nginx настроен и запущен. Ваша HTML страница доступна по адресу http://<ваш_ip_адрес>/"
