#!/bin/bash

# Обновляем список пакетов
sudo apt update

# Устанавливаем зависимости
sudo apt install -y wget apt-transport-https


# Создание директории для .NET
sudo mkdir -p /usr/share/dotnet

# Распаковка архивов
sudo tar zxf aspnetcore-runtime-6.0.36-linux-x64.tar.gz -C /usr/share/dotnet
sudo tar zxf dotnet-runtime-6.0.36-linux-x64.tar.gz -C /usr/share/dotnet
sudo tar zxf dotnet-sdk-6.0.428-linux-x64.tar.gz -C /usr/share/dotnet

# Создание символической ссылки на dotnet
sudo ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Проверка установки
dotnet --version

# Проверяем версии установленных компонентов
echo "Версия .NET SDK:"
dotnet --list-sdks

echo "Версия .NET Runtime:"
dotnet --list-runtimes

