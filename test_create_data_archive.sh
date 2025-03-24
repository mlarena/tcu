#!/bin/bash

# Путь к папке и архиву
SOURCE_PATH="/burstroy/data"
ARCHIVE_PATH="/burstroy/application/old_data.zip"

# Создать архив, исключая файлы с расширением .log
zip -r "$ARCHIVE_PATH" "$SOURCE_PATH" -x "*.log"

echo "Архив $ARCHIVE_PATH успешно создан"
