pipeline {
    agent any

    environment {
        IMAGE_NAME = "webpage"
        CONTAINER_NAME = "webpage_container"
        PORT = "8090"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository and checkout the latest code
                git branch: 'main', url: 'https://github.com/Arulrot/Jenkins_sonarqube_docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with index.html
                    docker.build("${IMAGE_NAME}:${env.BUILD_ID}", ".")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove existing container if running
                    sh """
                        if [ \$(docker ps -q --filter "name=${CONTAINER_NAME}") ]; then
                            docker stop ${CONTAINER_NAME}
                            docker rm ${CONTAINER_NAME}
                        fi
                    """

                    // Ensure port is free before running the container
                    sh """
                        if sudo netstat -tulnp | grep -q :${PORT}; then
                            echo "Port ${PORT} is in use, stopping process..."
                            sudo fuser -k ${PORT}/tcp
                        fi
                    """

                    // Run a new container with the latest build
                    sh "docker run -d --name ${CONTAINER_NAME} -p ${PORT}:80 ${IMAGE_NAME}:${env.BUILD_ID}"
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed!'
        }
        failure {
            echo 'Pipeline failed. Check the logs for errors!'
        }
    }
}
