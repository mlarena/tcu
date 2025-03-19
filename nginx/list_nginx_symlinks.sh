#!/bin/bash

# Проверяем, существует ли каталог /etc/nginx/sites-enabled
if [ ! -d "/etc/nginx/sites-enabled" ]; then
  echo "Каталог /etc/nginx/sites-enabled не существует."
  exit 1
fi

# Выводим символические ссылки в каталоге /etc/nginx/sites-enabled
echo "Символические ссылки в /etc/nginx/sites-enabled:"
ls -l /etc/nginx/sites-enabled
