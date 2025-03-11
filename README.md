# Jenkins Docker CI/CD Pipeline for Static Website Deployment

This project demonstrates a CI/CD pipeline using Jenkins and Docker to automate the deployment of a static HTML website to an AWS EC2 instance.

##  Overview

- **Objective**: Automate the deployment of a static HTML page to an EC2 instance using Docker containers.
- **Tools Used**: 
  - Jenkins (CI/CD Server)
  - Docker (Containerization)
  - AWS EC2 (Hosting)
  - GitHub (Source Code Management)

##  Prerequisites

1. **AWS EC2 Instance**:
   - Ubuntu or Amazon Linux AMI.
   - Security group allowing inbound traffic on ports:
     - `8080` (Jenkins)
     - `8090` (Web Server)
     - `22` (SSH)

2. **Docker**:
   - Installed on the EC2 instance.

3. **Jenkins**:
   - Installed on the EC2 instance with the **Docker Pipeline** plugin. 

4. **Git**:
   - Installed on the EC2 instance.

---

##  Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/Arulrot/Jenkins_docker_CI-CD-Pipeline.git
```


## Setup Instructions

### 1. **Create the Dockerfile**

Create a `Dockerfile` in your project root:

```dockerfile
# Base image with web server
FROM nginx:alpine

# Copy index.html into the web server directory
COPY index.html /usr/share/nginx/html/index.html
```

### 2. **Create the Jenkinsfile**

Create a `Jenkinsfile` in your project root:

```groovy
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
                    // Run Docker container, exposing port 8081 for the web server
                    docker.image("webpage:${env.BUILD_ID}").run('-d -p 8081:80')
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
```

### 3. **Configure Jenkins**

1. **Install Plugins**:
   - **Docker Pipeline Plugin**: To use Docker in Jenkins pipelines.
   - **Git Plugin**: To connect Jenkins with GitHub.

2. **Create a New Pipeline Job**:
   - Go to Jenkins Dashboard > New Item > Pipeline.
   - Set up the job with the appropriate configuration.

3. **Set Up Webhook on GitHub**:
   - Go to your GitHub repository.
   - Settings > Webhooks > Add webhook.
   - Payload URL: `http://<your-jenkins-server>/github-webhook/`
   - Content type: `application/json`
   - Events: Select "Just the push event."

### 4. **Run the Pipeline**

- **Trigger the Pipeline**:
  - Make a change to the repository or manually trigger the build from Jenkins.
  
- **View the Webpage**:
  - Open a browser and navigate to `http://localhost:8081` (or `http://<your-jenkins-server-ip>:8081`).

### 5. **Troubleshooting**

- **Port Already in Use**:
  If you encounter an error indicating that the port is already in use, change the port in the `docker run` command in the `Jenkinsfile`.

  ```groovy
  docker.image("webpage:${env.BUILD_ID}").run('-d -p 8082:80')
  ```

- **Verify Docker Container**:
  Check running containers and logs if there are issues:

  ```bash
  docker ps
  docker logs <container_id>
  ```

## Cleanup

To remove the Docker container and image after testing:

```bash
docker ps -a # List all containers
docker stop <container_id> # Stop the container
docker rm <container_id> # Remove the container
docker rmi webpage:${env.BUILD_ID} # Remove the Docker image
```

---


