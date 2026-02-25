FROM jenkins/jenkins:lts-jdk17

USER root

# Install dependencies including Java 21, Maven, Python, and Node.js
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Max-FutureTime=100000000 update --allow-insecure-repositories && apt-get install -y --allow-unauthenticated \
    maven \
    wget \
    openssh-client \
    sshpass \
    python3 \
    python3-venv \
    python3-pip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install Adoptium Java 21 (Since default apt might not have latest)
RUN mkdir -p /etc/apt/keyrings \
    && wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc \
    && echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list \
    && apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Max-FutureTime=100000000 update --allow-insecure-repositories \
    && apt-get install -y --allow-unauthenticated temurin-21-jdk

# Configure Jenkins to drop back to jenkins user
USER jenkins

# Install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt
