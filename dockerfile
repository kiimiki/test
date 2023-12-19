# Stage 1: Build the application
FROM maven:3.8.1-jdk-8 AS build
WORKDIR /app

# Copy SSH key to the container
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Add GitHub to known hosts
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Clone the Git repository
RUN git clone  git@github.com:kiimiki/test.git .

# Build the application
RUN mvn clean install

# Stage 2: Create the final image with Tomcat 7 and JDK 8
FROM tomcat:7

# Remove existing Tomcat default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the application from the build stage
COPY --from=build /app/target/java-jsp-diary.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
