# Используем базовый образ с Maven и Java
FROM maven:3.8.4-jdk-11-slim

# Устанавливаем Git
RUN apt-get update && apt-get install -y git

# Copy SSH key to the container
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Add GitHub to known hosts
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Устанавливаем рабочую директорию
WORKDIR /app

# Clone the Git repository
RUN git clone  git@github.com:kiimiki/test.git .

# Запускаем команду mvn tomcat7:run
CMD ["mvn", "tomcat7:run"]

# Экспонируем порт 8080
EXPOSE 8080
