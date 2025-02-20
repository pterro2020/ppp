# Используем официальный образ Python
FROM python:3.9

# Устанавливаем рабочую директорию
WORKDIR /app

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Копируем зависимости Python
COPY requirements.txt .

# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt gunicorn==20.1.0

# Копируем исходный код
COPY . .

# Сборка статики (если требуется)
RUN python manage.py collectstatic --no-input

# Открываем порт для веб-приложения
EXPOSE 8000

# Команда для запуска приложения
CMD ["gunicorn", "myproject.wsgi:application", "--bind", "158.160.4.189:8000"]
