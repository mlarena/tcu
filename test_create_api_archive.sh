#!/bin/bash

# Путь к папке и архиву
SOURCE_PATH="/burstroy/api"
ARCHIVE_PATH="/burstroy/application/old_api.zip"

# Создать архив, исключая файлы с расширением .log
zip -r "$ARCHIVE_PATH" "$SOURCE_PATH" -x "*.log"

echo "Архив $ARCHIVE_PATH успешно создан"
