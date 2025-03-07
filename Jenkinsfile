pipeline {
    agent any

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
                    def image = docker.build("webpage:${env.BUILD_ID}", ".")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove the existing container if it's running
                    sh """
                    docker ps -q --filter "publish=8090" | grep -q . && docker stop webpage_container && docker rm webpage_container || true
                    """

                    // Run Docker container, exposing port 80 for the web server
                    docker.image("webpage:${env.BUILD_ID}").run("-d --name webpage_container -p 8090:80")
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
