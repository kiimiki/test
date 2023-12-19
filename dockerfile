# Use base build Maven и Java
FROM maven:3.8.4-jdk-11-slim

# Install Git
RUN apt-get update && apt-get install -y git

# Copy SSH key to the container
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Add GitHub to known hosts
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Use working dir
WORKDIR /app

# Clone the Git repository
RUN git clone  git@github.com:kiimiki/test.git .

# Run app with command mvn tomcat7:run
CMD ["mvn", "tomcat7:run"]

# Expose port 8080
EXPOSE 8080
