FROM debian:bullseye

# Устанавливаем Icecast и необходимые пакеты
RUN apt-get update && apt-get install -y \
    icecast2 \
    && rm -rf /var/lib/apt/lists/*

# Копируем конфигурационные файлы в контейнер
COPY icecast.xml /etc/icecast2/icecast.xml

# Указываем рабочую директорию
WORKDIR /etc/icecast2

# Открываем порт 8000
EXPOSE 8000

# Запуск Icecast с конфигурационным файлом
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
