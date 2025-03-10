#!/bin/bash

# Вывод всех сервисов
echo "Все сервисы на системе:"
systemctl list-units --type=service --all

# Вывод активных сервисов
echo -e "\nАктивные сервисы:"
systemctl list-units --type=service --state=active

# Вывод неактивных сервисов
echo -e "\nНеактивные сервисы:"
systemctl list-units --type=service --state=inactive

# Вывод ошибочных сервисов
echo -e "\nОшибочные сервисы:"
systemctl list-units --type=service --state=failed
