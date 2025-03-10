#!/bin/bash

# Параметры подключения к базе данных
DB_NAME="burstroydb"
DB_USER="postgres"
BACKUP_FILE="backup.dump"

# Проверка наличия файла резервной копии
if [ ! -f "$BACKUP_FILE" ]; then
  echo "Файл резервной копии не найден: $BACKUP_FILE"
  exit 1
fi

# Проверка наличия утилиты pg_restore
if ! command -v pg_restore &> /dev/null; then
  echo "Утилита pg_restore не найдена. Пожалуйста, установите PostgreSQL."
  exit 1
fi

# Создание новой базы данных
echo "Создание новой базы данных: $DB_NAME"
sudo -u postgres createdb $DB_NAME

# Восстановление базы данных из резервной копии
echo "Восстановление базы данных из резервной копии: $BACKUP_FILE"
sudo -u postgres pg_restore -U $DB_USER -d $DB_NAME $BACKUP_FILE

# Проверка успешности восстановления
if [ $? -eq 0 ]; then
  echo "База данных успешно восстановлена."
else
  echo "Ошибка при восстановлении базы данных."
  exit 1
fi
