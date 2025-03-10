#!/bin/bash

# Функция для создания директории, если она не существует
create_directory() {
    local dir_path=$1
    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path"
        if [ $? -eq 0 ]; then
            echo "Директория $dir_path успешно создана."
        else
            echo "Ошибка при создании директории $dir_path."
            exit 1
        fi
    else
        echo "Директория $dir_path уже существует."
    fi
}

# Функция для распаковки архива
unzip_archive() {
    local zip_file=$1
    local dest_dir=$2
    if [ -f "$zip_file" ]; then
        echo "Распаковка $zip_file в $dest_dir..."
        unzip -o "$zip_file" -d "$dest_dir"
        if [ $? -eq 0 ]; then
            echo "Архив $zip_file успешно распакован в $dest_dir."
        else
            echo "Ошибка при распаковке $zip_file."
            exit 1
        fi
    else
        echo "Файл $zip_file не найден."
        exit 1
    fi
}

# Создание целевых директорий в корневой директории
create_directory "/burstroy/web"
create_directory "/burstroy/data"
create_directory "/burstroy/api"

# Распаковка архивов в соответствующие директории
unzip_archive "web.zip" "/burstroy/web"
unzip_archive "data.zip" "/burstroy/data"
unzip_archive "api.zip" "/burstroy/api"

echo "Все архивы успешно распакованы."
