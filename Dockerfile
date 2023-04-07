FROM jenkins/jenkins:lts
USER root

RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg \
                       lsb-release

# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's stable repository to the system
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker and related utilities
RUN apt-get update && \
    apt-get install -y docker-ce-cli docker-compose

# Switch back to Jenkins user
USER jenkins
