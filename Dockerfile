FROM ubuntu:latest

# Обновление системы
RUN apt-get update && apt-get upgrade -y

# Установка необходимых пакетов
RUN apt-get install -y build-essential libxml2-dev libxslt-dev curl wget git

# Загрузка и установка Icecast
RUN wget https://downloads.xiph.org/releases/icecast/icecast-2.4.4.tar.gz
RUN tar xzvf icecast-2.4.4.tar.gz
WORKDIR /icecast-2.4.4

# Проверяем наличие нужных файлов
RUN ls -la

# Выполняем конфигурирование и установку поэтапно
RUN ./configure
RUN make
RUN make install

# Копирование конфигурационного файла
COPY icecast.xml /etc/icecast2/icecast.xml

# Запуск сервера
CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]
