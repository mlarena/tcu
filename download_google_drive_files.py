import requests
from bs4 import BeautifulSoup

# Функция для получения прямой ссылки на файл Google Drive
def get_direct_download_link(file_id):
    URL = "https://drive.google.com/uc"
    session = requests.Session()
    response = session.get(URL, params={'export': 'download', 'id': file_id}, stream=True)

    # Проверка на наличие предупреждения о вирусах
    if "download_warning" in response.url:
        soup = BeautifulSoup(response.content, "html.parser")
        confirm_button = soup.find("a", {"id": "uc-download-link"})
        if confirm_button:
            confirm_link = confirm_button["href"]
            response = session.get(confirm_link, stream=True)

    return response

# Прямые ссылки на файлы
file_ids = {
    'api.zip': '1lNw5ENtjhZ6pgLrM-w-5BX6sbCss9-5s',
    'data.zip': '1CCw2TDkpYgBNKMfEq_TwHadM4M-icL1R',
    'web.zip': '1fui-bVNCpbqXNAm3huU8IE3osy_z9vpa'
}

# Скачивание файлов
for filename, file_id in file_ids.items():
    print(f"Скачивание {filename}...")
    response = get_direct_download_link(file_id)
    with open(filename, 'wb') as f:
        for chunk in response.iter_content(chunk_size=8192):
            if chunk:
                f.write(chunk)
    print(f"Файл {filename} успешно загружен.")
