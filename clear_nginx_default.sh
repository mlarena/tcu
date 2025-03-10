#!/bin/bash

# Удаление содержимого файла /etc/nginx/sites-available/default
sudo truncate -s 0 /etc/nginx/sites-available/default

# Проверка конфигурации Nginx
sudo nginx -t

# Перезапуск Nginx
sudo systemctl restart nginx

echo "Содержимое файла /etc/nginx/sites-available/default успешно удалено и Nginx перезапущен."
