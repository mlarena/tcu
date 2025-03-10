#!/bin/bash

# Функция для вывода версии nginx
check_nginx_version() {
    if command -v nginx > /dev/null; then
        echo "Nginx version: $(nginx -v 2>&1 | grep -o '[0-9]\.[0-9]\.[0-9]')"
    else
        echo "Nginx is not installed."
    fi
}

# Функция для вывода версии PostgreSQL
check_postgres_version() {
    if command -v psql > /dev/null; then
        echo "PostgreSQL version: $(psql --version | grep -o '[0-9]\.[0-9]')"
    else
        echo "PostgreSQL is not installed."
    fi
}

# Функция для вывода версии .NET
check_dotnet_version() {
    if command -v dotnet > /dev/null; then
        echo "Dotnet version: $(dotnet --version)"
    else
        echo ".NET is not installed."
    fi
}

# Вызов функций
check_nginx_version
check_postgres_version
check_dotnet_version
