#!/bin/bash

# Выводим структуру каталогов Nginx
echo "Структура каталогов Nginx:"
tree /etc/nginx

# Выводим основной конфигурационный файл Nginx
echo -e "\nОсновной конфигурационный файл Nginx (nginx.conf):"
cat /etc/nginx/nginx.conf

# Выводим конфигурационные файлы сайтов в sites-available
echo -e "\nКонфигурационные файлы сайтов в sites-available:"
ls -l /etc/nginx/sites-available

# Выводим символические ссылки в sites-enabled
echo -e "\nСимволические ссылки в sites-enabled:"
ls -l /etc/nginx/sites-enabled

# Выводим содержимое конфигурационных файлов сайтов
echo -e "\nСодержимое конфигурационных файлов сайтов:"
for file in /etc/nginx/sites-available/*; do
    echo -e "\n$file:"
    cat "$file"
done
