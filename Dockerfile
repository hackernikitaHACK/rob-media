FROM debian:bullseye

# Устанавливаем необходимые утилиты
RUN apt-get update && apt-get install -y \
    curl \
    nano \
    vim \
    sudo \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Настраиваем SSH
RUN mkdir /var/run/sshd
RUN echo 'root:rootpassword' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Открываем порт для SSH
EXPOSE 22

# Запуск SSH сервера
CMD ["/usr/sbin/sshd", "-D"]

