pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "your-docker-image-name"
        COMPOSE_PROJECT_NAME = "your-compose-project-name"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    docker.build(env.DOCKER_IMAGE_NAME, '-f Dockerfile .')
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                script {
                    // Deploy services using Docker Compose
                    docker.withRegistry('', 'dockerhub') {
                        sh "docker-compose -p ${env.COMPOSE_PROJECT_NAME} up -d"
                    }
                }
            }
        }
    }

    post {
        success {
            // Clean up after a successful deployment
            cleanUp()
        }
        failure {
            // Clean up after a failed deployment
            cleanUp()
        }
    }
}

def cleanUp() {
    script {
        // Remove Docker containers and images
        sh "docker-compose -p ${env.COMPOSE_PROJECT_NAME} down"
        sh "docker rmi -f ${env.DOCKER_IMAGE_NAME}"
    }
}
