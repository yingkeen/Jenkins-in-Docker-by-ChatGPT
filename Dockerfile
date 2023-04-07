FROM jenkins/jenkins:2.387.2

USER root

# Install necessary packages
RUN apt-get update && \
    apt-get install -y lsb-release && \
    apt-get install -y curl && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/*

# Install Docker GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
RUN apt-get update && \
    apt-get install -y docker-ce-cli && \
    usermod -aG docker jenkins && \
    rm -rf /var/lib/apt/lists/*

USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
