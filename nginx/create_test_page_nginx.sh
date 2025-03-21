#!/bin/bash

# Создаем каталог для HTML страницы, если он не существует
sudo mkdir -p /burstroy/testweb

# Создаем указанную HTML страницу
sudo bash -c 'cat > /burstroy/testweb/index.html <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test HTML Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        #fact {
            margin-top: 20px;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <h1>Random Cat Fact</h1>
    <button id="fetchFactBtn">Get Cat Fact</button>
    <div id="fact"></div>

    <script>
        document.getElementById('fetchFactBtn').addEventListener('click', function() {
            fetch('https://catfact.ninja/fact')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('fact').innerText = data.fact;
                })
                .catch(error => {
                    console.error('Error fetching cat fact:', error);
                    document.getElementById('fact').innerText = 'Failed to fetch cat fact.';
                });
        });
    </script>
</body>
</html>
EOF'


# Создаем конфигурационный файл для нашего сайта
sudo bash -c 'cat > /etc/nginx/sites-available/testweb <<EOF
server {
    listen 80;
    listen [::]:80 default_server;

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
