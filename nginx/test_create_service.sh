#!/bin/bash

# Путь к исполняемому файлу
EXEC_PATH="/burstroy/testweb/BlazorApp1.dll"

# Создать файл службы
SERVICE_FILE="/etc/systemd/system/testweb.service"

cat <<EOL | sudo tee $SERVICE_FILE
[Unit]
Description=Test Web Service

[Service]
WorkingDirectory=/burstroy/testweb
ExecStart=/usr/bin/dotnet $EXEC_PATH --urls http://*:5005
Restart=always
RestartSec=10
SyslogIdentifier=testweb
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production

[Install]
WantedBy=multi-user.target
EOL

# Перезагрузить systemd и запустить службу
sudo systemctl daemon-reload
sudo systemctl enable testweb.service
sudo systemctl start testweb.service

echo "Служба для тестового сайта успешно создана и запущена"
