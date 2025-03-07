pipeline {
    agent any

    environment {
        IMAGE_NAME = "webpage:${env.BUILD_ID}"
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Cloning repository..."
                    git branch: 'main', url: 'https://github.com/Arulrot/Jenkins_sonarqube_docker.git'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image: ${IMAGE_NAME}"
                    docker.build(IMAGE_NAME, ".")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running Docker container..."
                    docker.image(IMAGE_NAME).run('-d -p 8081:80')
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    echo "Cleaning up old Docker images..."
                    sh 'docker system prune -f'
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed! Check logs for details.'
        }
        always {
            echo 'Pipeline execution completed!'
        }
    }
}
