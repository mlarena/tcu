#!/bin/bash

# Проверка наличия аргумента (имя архива)
if [ -z "$1" ]; then
    echo "Использование: $0 <имя_архива>"
    exit 1
fi

# Имя архива
archive_name=$1

# Разбиение архива на части по 70 МБ
split -b 70M "$archive_name" "${archive_name}.part."

echo "Архив $archive_name успешно разбит на части по 70 МБ."
