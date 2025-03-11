pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Clone the repository and checkout the latest code
                git branch: 'main', url: 'https://github.com/Arulrot/Jenkins_docker_CI-CD-Pipeline.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image with index.html
                    def image = docker.build("webpage:${env.BUILD_ID}", ".")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run Docker container, exposing port 80 for the web server
                    docker.image("webpage:${env.BUILD_ID}").run('-d -p 8090:80')
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline complete!'
        }
    }
}
