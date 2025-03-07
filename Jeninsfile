pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Pull the latest code from GitHub
                git branch: 'main', url: 'https://github.com/Arulrot/Jenkins_sonarqube_docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build a Docker image using the Dockerfile
                    def image = docker.build("webpage:${env.BUILD_ID}", ".")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the container on port 8081
                    docker.image("webpage:${env.BUILD_ID}").run('-d -p 8081:80')
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution completed!'
        }
    }
}
