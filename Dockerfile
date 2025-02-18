FROM python:3.10-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD python manage.py collectstatic --noinput && \
    python manage.py migrate --noinput && \
    gunicorn --bind 158.160.84.43:8000 autoparking.wsgi
