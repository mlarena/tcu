#!/bin/bash

# Остановить и отключить службу
sudo systemctl stop testweb.service
sudo systemctl disable testweb.service

# Удалить файл службы
sudo rm /etc/systemd/system/testweb.service

# Перезагрузить systemd
sudo systemctl daemon-reload

echo "Служба для тестового сайта успешно удалена"
