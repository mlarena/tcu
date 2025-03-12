#!/bin/bash

# Обновление списка пакетов
sudo apt update

# Установка необходимых пакетов для работы с GPG
sudo apt install -y gnupg gnupg2 gnupg1

# Добавление репозитория PostgreSQL
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Импорт ключа GPG для репозитория PostgreSQL
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Обновление списка пакетов после добавления репозитория
sudo apt update

# Установка PostgreSQL 13
sudo apt install -y postgresql-13 postgresql-contrib-13

# Запуск PostgreSQL сервиса
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Настройка пароля для пользователя postgres
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'burstroy';"

# Вывод версии установленного PostgreSQL
postgres_version=$(psql --version | head -n 1)
echo "Установленная версия PostgreSQL: $postgres_version"

echo "PostgreSQL 13 установлен и настроен с паролем для пользователя postgres: burstroy"
