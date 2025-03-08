pipeline {
    agent any
    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/Arulrot/Jenkins_sonarqube_docker.git'
            }
        }
        stage('Code Analysis') {
            steps {
                sh 'sonar-scanner -Dsonar.projectKey=portfolio -Dsonar.sources=. -Dsonar.host.url=http://http://13.201.223.126/:9000'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t portfolio:latest .'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker stop portfolio || true && docker rm portfolio || true'
                sh 'docker run -d --name portfolio -p 80:80 portfolio:latest'
            }
        }
    }
}
