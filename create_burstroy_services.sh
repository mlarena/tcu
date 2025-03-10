#!/bin/bash

# Создание файла службы для burstroy-api.service
sudo bash -c 'cat > /etc/systemd/system/burstroy-api.service' <<EOF
[Unit]
Description=Burstroy API Service

[Service]
WorkingDirectory=/burstroy/api/
ExecStart=/usr/bin/dotnet /burstroy/api/Burstroy.API.dll
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=burstroy_api
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOF

# Создание файла службы для burstroy-data.service
sudo bash -c 'cat > /etc/systemd/system/burstroy-data.service' <<EOF
[Unit]
Description=Burstroy DATA Service

[Service]
WorkingDirectory=/burstroy/data/
ExecStart=/usr/bin/dotnet /burstroy/data/Burstroy.DataServer.Service.dll
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=burstroy_data
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOF

# Создание файла службы для burstroy-web.service
sudo bash -c 'cat > /etc/systemd/system/burstroy-web.service' <<EOF
[Unit]
Description=Burstroy WEB Service

[Service]
WorkingDirectory=/burstroy/web/
ExecStart=/usr/bin/dotnet /burstroy/web/Burstroy.TCU.WebAssembly.Server.dll
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=burstroy_web
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOF

# Перезагрузка систематического демона
sudo systemctl daemon-reload

# Запуск служб
sudo systemctl start burstroy-api.service
sudo systemctl start burstroy-data.service
sudo systemctl start burstroy-web.service

# Включение автозапуска служб при загрузке системы
sudo systemctl enable burstroy-api.service
sudo systemctl enable burstroy-data.service
sudo systemctl enable burstroy-web.service

echo "Службы burstroy-api, burstroy-data и burstroy-web успешно созданы и запущены."
