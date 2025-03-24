#!/bin/bash

# Путь к папке и архиву
SOURCE_PATH="/burstroy/web"
ARCHIVE_PATH="/burstroy/application/old_web.zip"

# Создать архив, исключая файлы с расширением .log и содержимое папки /burstroy/web/wwwroot/snapshots
zip -r "$ARCHIVE_PATH" "$SOURCE_PATH" -x "*.log" "/burstroy/web/wwwroot/snapshots/*"

echo "Архив $ARCHIVE_PATH успешно создан"
