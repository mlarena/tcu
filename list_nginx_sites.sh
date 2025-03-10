#!/bin/bash

# Директории, где могут находиться конфигурационные файлы Nginx
NGINX_CONF_DIRS=("/etc/nginx/sites-enabled" "/etc/nginx/conf.d")

# Функция для извлечения информации о сайтах и портах
extract_sites_and_ports() {
  local conf_dir=$1
  echo "Сайты и порты в директории $conf_dir:"
  for conf_file in "$conf_dir"/*; do
    if [[ -f "$conf_file" ]]; then
      site_name=$(basename "$conf_file" .conf)
      port=$(grep -oP 'listen\s+\K\d+' "$conf_file")
      echo "Сайт: $site_name, Порт: $port"
    fi
  done
  echo
}

# Проход по всем директориям и извлечение информации
for conf_dir in "${NGINX_CONF_DIRS[@]}"; do
  if [[ -d "$conf_dir" ]]; then
    extract_sites_and_ports "$conf_dir"
  fi
done
