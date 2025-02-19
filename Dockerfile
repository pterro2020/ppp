# Используем официальный образ Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем зависимости Python
COPY requirements.txt .

# Устанавливаем зависимости Python
RUN pip install --no-cache-dir -r requirements.txt

# Копируем статические файлы (HTML, CSS, JS)
COPY static ./static
COPY templates ./templates

# Копируем исходный код Python
COPY *.py ./

# Устанавливаем Node.js (если требуется для JavaScript)
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Устанавливаем зависимости JavaScript (если есть package.json)
COPY package.json .
COPY package-lock.json .
RUN npm install

# Открываем порт для веб-приложения
EXPOSE 5000

# Команда для запуска приложения
CMD ["python", "app.py"]
