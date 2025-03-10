#!/bin/bash

# Обновление списка пакетов
sudo apt-get update

# Установка curl
sudo apt-get install -y curl

# Проверка успешной установки curl
if command -v curl &> /dev/null
then
    echo "curl успешно установлен"
else
    echo "Ошибка при установке curl"
    exit 1
fi

# Установка Nginx
sudo apt install -y nginx

# Проверка успешной установки Nginx
if command -v nginx &> /dev/null
then
    echo "Nginx успешно установлен."

    # Получение версии Nginx
    nginx_version=$(nginx -v 2>&1 | grep -oE 'nginx/[0-9]+\.[0-9]+\.[0-9]+')
    echo "Версия Nginx: $nginx_version"

    # Запуск Nginx
    sudo systemctl start nginx

    # Включение Nginx в автозагрузку
    sudo systemctl enable nginx

    echo "Nginx запущен и добавлен в автозагрузку."
else
    echo "Ошибка установки Nginx."
fi

# Установка зависимостей
sudo apt-get install -y \
    ca-certificates \
    libc6 \
    libgcc-s1 \
    libgssapi-krb5-2 \
    libicu70 \
    liblttng-ust1 \
    libssl3 \
    libstdc++6 \
    libunwind8 \
    zlib1g

# Проверка успешности установки зависимостей
if [ $? -eq 0 ]; then
    echo "Все зависимости успешно установлены."
else
    echo "Ошибка при установке зависимостей."
fi

# Добавление репозитория Microsoft
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Обновление списка пакетов
sudo apt-get update

# Установка ASP.NET Core Runtime
sudo apt-get install -y aspnetcore-runtime-6.0

# Установка .NET Runtime
sudo apt-get install -y dotnet-runtime-6.0

# Установка .NET SDK
sudo apt-get install -y dotnet-sdk-6.0

# Проверка установки .NET
echo "Установка завершена!"
echo "Установленная версия .NET:"
dotnet --version

# Установка PostgreSQL 13
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
