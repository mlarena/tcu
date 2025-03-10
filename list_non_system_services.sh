#!/bin/bash

# Вывод всех несистемных сервисов
echo "Все несистемные сервисы:"

# Получение списка всех сервисов
all_services=$(systemctl list-units --type=service --all --no-pager --no-legend | awk '{print $1}')

# Фильтрация несистемных сервисов
non_system_services=()
for service in $all_services; do
  if [[ -f /etc/systemd/system/$service.service || -f /lib/systemd/system/$service.service ]]; then
    non_system_services+=("$service")
  fi
done

# Вывод несистемных сервисов
for service in "${non_system_services[@]}"; do
  echo "$service"
done
