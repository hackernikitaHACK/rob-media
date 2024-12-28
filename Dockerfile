# Базовый образ с Debian
FROM debian:bullseye

# Устанавливаем необходимые пакеты
RUN apt-get update && apt-get install -y \
    icecast2 \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Копируем конфигурационные файлы в контейнер
COPY icecast.xml /etc/icecast2/icecast.xml
COPY mime.types /etc/mime.types

# Открываем порт 8000 для доступа к серверу
EXPOSE 8000

# Создаём директории для логов и веб-ресурсов
RUN mkdir -p /app/logs /app/web /app/admin

# Устанавливаем рабочую директорию
WORKDIR /etc/icecast2

# Запуск Icecast с указанным конфигом
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
