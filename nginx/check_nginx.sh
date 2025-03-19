#!/bin/bash

# Проверка, установлен ли Nginx
if command -v nginx &> /dev/null
then
    echo "Nginx установлен."

    # Получение версии Nginx
    nginx_version=$(nginx -v 2>&1 | grep -oE 'nginx/[0-9]+\.[0-9]+\.[0-9]+')
    echo "Версия Nginx: $nginx_version"

    # Проверка веб-приложений на различных портах
    echo "Проверка веб-приложений на различных портах..."

    # Список портов для проверки
    ports=(80 8080 8443 443)

    for port in "${ports[@]}"
    do
        # Проверка, слушает ли Nginx на данном порту
        if lsof -i :$port | grep -q nginx
        then
            echo "Nginx слушает на порту $port"

            # Получение информации о веб-приложении
            curl -s http://localhost:$port | grep -oE '<title>.*</title>'
        else
            echo "Nginx не слушает на порту $port"
        fi
    done
else
    echo "Nginx не установлен."
fi