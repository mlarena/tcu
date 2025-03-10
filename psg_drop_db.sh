#!/bin/bash

# Переменные
DB_NAME="burstroydb"

# Вывод списка всех баз данных
echo "Список всех баз данных:"
sudo -u postgres psql -c "\l"


# Проверка существования базы данных
DB_EXISTS=$(sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")
if [ -n "$DB_EXISTS" ]; then
  echo "Закрытие существующих подключений к базе данных $DB_NAME."
  sudo -u postgres psql -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='$DB_NAME';"

  echo "Удаление существующей базы данных $DB_NAME."
  sudo -u postgres psql -c "DROP DATABASE $DB_NAME;"
fi

# Вывод списка всех баз данных
echo "Список всех баз данных:"
sudo -u postgres psql -c "\l"
