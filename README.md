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

This command runs the Jenkins container and mounts the host's Docker socket (`/var/run/docker.sock`) to the container's Docker socket

# Accessing Jenkins

To access Jenkins, open a web browser and go to http://localhost:8080.

# Disadvantages of Using Unix Socket to Access Docker

Using the Unix socket to access Docker from within a container is convenient, but it has some disadvantages:

- It requires the container to have access to the host's Docker daemon, which can be a security risk.
- It does not work with remote Docker daemons, which are commonly used in production environments.
- It can cause permission issues if the container's user does not have permission to access the Docker socket.
- It limits the Docker capabilities available to your Jenkins pipelines, as some Docker commands require a running Docker daemon.
