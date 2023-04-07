# Jenkins in Docker

This repository contains a Dockerfile for Jenkins that can deploy Docker containers on the host machine using Docker socket. This repository is created and managed using ChatGPT, a language model trained by OpenAI.

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
docker run -d --restart=on-failure -p 8080:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock -v jenkins-data:/var/jenkins_home my-jenkins
```

This command runs the Jenkins container and mounts the host's Docker socket (`/var/run/docker.sock`) to the container's Docker socket

