#!/bin/bash

# Переменные
DB_NAME="burstroydb"
DB_OWNER="postgres"
BACKUP_FILE="nn.sql"

# Проверка наличия файла backup.sql
if [ ! -f "$BACKUP_FILE" ]; then
  echo "Файл $BACKUP_FILE не найден. Пожалуйста, убедитесь, что файл существует в текущей директории."
  exit 1
fi

# Создание базы данных
sudo -u postgres psql -c "CREATE DATABASE $DB_NAME OWNER $DB_OWNER;"
echo "База данных $DB_NAME создана с владельцем $DB_OWNER."

# Восстановление базы данных из файла 
sudo -u postgres psql $DB_NAME < $BACKUP_FILE
echo "База данных $DB_NAME восстановлена из файла $BACKUP_FILE."

# Вывод списка всех баз данных
echo "Список всех баз данных:"
sudo -u postgres psql -c "\l"

# Вывод размера базы данных burstroydb
echo "Размер базы данных $DB_NAME:"
sudo -u postgres psql -c "SELECT pg_size_pretty(pg_database_size('$DB_NAME'));"