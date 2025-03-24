#!/bin/bash

# Путь к архиву и папке назначения
ARCHIVE_PATH="/burstroy/application/testweb.zip"
DESTINATION_PATH="/burstroy/testweb"

# Разархивировать файл
unzip -o "$ARCHIVE_PATH" -d "$DESTINATION_PATH"

echo "Архив успешно развернут в $DESTINATION_PATH"
