FROM node:20-bullseye

# Install OpenSSH Server and Java 17 for Jenkins Agent
RUN apt-get update && apt-get install -y openssh-server sudo openjdk-17-jre

# Create a user for deployment
RUN useradd -m -s /bin/bash deployer && \
    echo "deployer:password" | chpasswd && \
    adduser deployer sudo

# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
