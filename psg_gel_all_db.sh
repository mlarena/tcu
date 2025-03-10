#!/bin/bash

# Переменные
DB_NAME="burstroydb"

# Вывод списка всех баз данных
echo "Список всех баз данных:"
sudo -u postgres psql -c "\l"

# Вывод размера базы данных burstroydb
echo "Размер базы данных $DB_NAME:"
sudo -u postgres psql -c "SELECT pg_size_pretty(pg_database_size('$DB_NAME'));"