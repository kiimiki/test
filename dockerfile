version: '3'

services:
  tomcat:
    image: "jsp-app-1-2:latest"
    ports:
      - "8080:80"
    environment:
      MYSQL_HOST: mysql
    deploy:
      # replicas: 1
    depends_on:
      - mysql
    networks:
      - net-1

  mysql:
    image: "mysql:8.0"
    ports:
      - '3306:33060'
    volumes:
      - /opt/docker/test-1/mysql-data:/var/lib/mysql
      - /opt/docker/test-1/mysql-data-import:/docker-entrypoint-initdb.d
    command: --init-file /docker-entrypoint-initdb.d/db_table.sql --default-authentication-plugin=caching_sha2_password
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: jspDiary
      MYSQL_USER: test_user
      MYSQL_PASSWORD: test_password
    networks:
      - net-1
  
volumes:
  mysql-data:

networks:
  net-1:
    external: true
