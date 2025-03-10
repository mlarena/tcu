#!/bin/bash

# Add Microsoft package repository
wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb

# Update package list
sudo apt-get update

# Install ASP.NET Core Runtime
sudo apt-get install -y aspnetcore-runtime-6.0

# Install .NET Runtime
sudo apt-get install -y dotnet-runtime-6.0

# Install .NET SDK
sudo apt-get install -y dotnet-sdk-6.0

# Verify installation
echo "Установка завершена!"
echo "Установленная версия .NET:"
dotnet --version
ls -l