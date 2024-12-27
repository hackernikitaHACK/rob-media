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

# Копируем директорию для логов и веб-ресурсов
RUN mkdir -p /app/logs /app/web /app/admin

# Создаем группу и пользователя для Icecast (не запускать от root)
RUN groupadd -r icecast && useradd -r -g icecast icecast

# Применяем права владельца для конфигурации Icecast
RUN chown -R icecast:icecast /etc/icecast2 /app

# Устанавливаем рабочую директорию
WORKDIR /etc/icecast2

# Запускаем Icecast от имени пользователя icecast
USER icecast
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]

