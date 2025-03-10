#!/bin/bash

# Пути к файлам
file1="/burstroy/api/Burstroy.API.dll"
file2="/burstroy/data/Burstroy.DataServer.Service.dll"
file3="/burstroy/web/Burstroy.TCU.WebAssembly.Server.dll"

# Функция для проверки существования файла
check_file() {
    local file=$1
    if [ -f "$file" ]; then
        echo "Файл $file существует."
    else
        echo "Файл $file не существует."
    fi
}

# Проверка файлов
check_file "$file1"
check_file "$file2"
check_file "$file3"
