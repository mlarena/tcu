#!/bin/bash

# URL-адреса для скачивания
ASPNETCORE_RUNTIME_URL="https://download.visualstudio.microsoft.com/download/pr/0b5c607f-6f5d-4636-b03e-b4d342e835f5/936a8776b65b47a98010b7ce2e0d8c01/aspnetcore-runtime-6.0.36-linux-x64.tar.gz"
DOTNET_RUNTIME_URL="https://download.visualstudio.microsoft.com/download/pr/0b5c607f-6f5d-4636-b03e-b4d342e835f5/936a8776b65b47a98010b7ce2e0d8c01/dotnet-runtime-6.0.36-linux-x64.tar.gz"
DOTNET_SDK_URL="https://download.visualstudio.microsoft.com/download/pr/0b5c607f-6f5d-4636-b03e-b4d342e835f5/936a8776b65b47a98010b7ce2e0d8c01/dotnet-sdk-6.0.428-linux-x64.tar.gz"

# Директория для скачивания
DOWNLOAD_DIR="/tmp/dotnet"

# Создаем директорию для скачивания
mkdir -p $DOWNLOAD_DIR

# Функция для скачивания и установки
download_and_install() {
    local url=$1
    local filename=$(basename $url)
    local extract_dir="${filename%.tar.gz}"

    echo "Скачивание $filename..."
    curl -L -o $DOWNLOAD_DIR/$filename $url

    echo "Распаковка $filename..."
    mkdir -p $DOWNLOAD_DIR/$extract_dir
    tar -xzf $DOWNLOAD_DIR/$filename -C $DOWNLOAD_DIR/$extract_dir

    echo "Установка $filename..."
    sudo $DOWNLOAD_DIR/$extract_dir/install.sh
}

# Скачивание и установка aspnetcore-runtime-6.0
download_and_install $ASPNETCORE_RUNTIME_URL

# Скачивание и установка dotnet-runtime-6.0
download_and_install $DOTNET_RUNTIME_URL

# Скачивание и установка dotnet-sdk-6.0
download_and_install $DOTNET_SDK_URL

# Очистка временных файлов
echo "Очистка временных файлов..."
rm -rf $DOWNLOAD_DIR

# Вывод установленной версии .NET
echo "Установка завершена!"
echo "Установленная версия .NET:"
dotnet --version
