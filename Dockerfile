# Базовый образ Python
FROM python:3.9-alpine

# Установка зависимостей
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    nginx \
    && rm -rf /var/lib/apt/lists/*

# Рабочая директория
WORKDIR /app

# Копирование зависимостей
COPY requirements.txt .

# Установка Python-зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Копирование проекта
COPY . .

# Копирование конфигурации Nginx
COPY nginx.conf /etc/nginx/sites-available/default

# Порт для Django
EXPOSE 8000

# Команда для запуска сервера
CMD ["sh", "-c", "python manage.py migrate && python manage.py collectstatic --noinput && service nginx start && python manage.py runserver 0.0.0.0:8000"]
# Сборка статики (если требуется)
RUN python manage.py collectstatic --no-input

# Открываем порт для веб-приложения
EXPOSE 8000

# Команда для запуска приложения
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "89.169.164.174:8000"]
