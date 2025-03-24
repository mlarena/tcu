#!/bin/bash

# Путь к архиву и папке назначения
ARCHIVE_PATH="/burstroy/application/serg_api.zip"
DESTINATION_PATH="/burstroy/api"

# Распаковать архив
unzip -o "$ARCHIVE_PATH" -d "$DESTINATION_PATH"

echo "Архив $ARCHIVE_PATH успешно распакован в $DESTINATION_PATH"
