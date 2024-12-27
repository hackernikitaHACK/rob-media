FROM debian:bullseye

RUN apt-get update && apt-get install -y icecast2 && \
    mkdir -p /app/logs /app/web /app/admin

COPY icecast.xml /etc/icecast2/icecast.xml
COPY mime.types /app/mime.types

CMD ["icecast2", "-c", "/etc/icecast2/icecast.xml"]


