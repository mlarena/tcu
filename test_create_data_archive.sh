#!/bin/bash

# Путь к папке и архиву
SOURCE_PATH="/burstroy/data"
ARCHIVE_PATH="/burstroy/application/old_data.zip"

# Создать архив
zip -r "$ARCHIVE_PATH" "$SOURCE_PATH"

echo "Архив $ARCHIVE_PATH успешно создан"
