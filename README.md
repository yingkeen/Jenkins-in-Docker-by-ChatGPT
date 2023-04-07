# Jenkins in Docker

This repository contains a Dockerfile to build a Jenkins container that has access to the Docker daemon on the host machine by mounting the host's Docker Unix socket onto the container. This repository is created and managed using ChatGPT, a language model trained by OpenAI.

## Features
- Uses the official Jenkins LTS Docker image as the base
- Installs Docker CLI in the Jenkins container
- Mounts the host's Docker Unix socket onto the container for Docker commands to be executed from the Jenkins container.

## Prerequisites

- Docker

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yingkeen/Jenkins-in-Docker-by-ChatGPT.git
```

2. Build the Jenkins image:
```bash
docker build -t my-jenkins .
```

3. Run the Jenkins container with Docker socket:
```bash
docker run --name my-jenkins -d --restart=on-failure -p 8080:8080 -p 50000:50000 --group-add $(stat -c '%g' /var/run/docker.sock) -v /var/run/docker.sock:/var/run/docker.sock -v jenkins-data:/var/jenkins_home my-jenkins
```

This command runs the Jenkins container and mounts the host's Docker socket (`/var/run/docker.sock`) to the container's Docker socket with the group that owns the /var/run/docker.sock file on the host to the container's group list, so that the container can access the Docker socket.

## Accessing Jenkins

To access Jenkins, open a web browser and go to http://localhost:8080.

## Deploy a sample container
1. Login to the Jenkins web interface by navigating to http://localhost:8080 in your web browser. The default username is admin and the password can be found in the Jenkins logs or in the Dockerfile.
2. Create a new Jenkins project by clicking on the "New Item" button on the Jenkins dashboard.
3. Select "Freestyle project" and give your project a name.
4. Under the "Source Code Management" section, select "None".
5. Under the "Build" section, click on the "Add build step" button and select "Execute shell".
6. In the shell command, enter the following:
```bash
docker run --name my-container -d nginx
```
This will deploy a new Docker container running the Nginx web server.

7. Click on the "Save" button to save your project configuration.
8. Click on the "Build Now" button to build and deploy the container.
9. You can view the logs of the container by clicking on the container name under the "Build History" section of the project page.

# Disadvantages of Using Unix Socket to Access Docker

Using the Unix socket to access Docker from within a container is convenient, but it has some disadvantages:

- It limits the Docker capabilities available to your Jenkins pipelines, as some Docker commands require a running Docker daemon.
- It can be a security risk to expose the Docker socket to containers.

Be sure to consider these factors when using this method.
