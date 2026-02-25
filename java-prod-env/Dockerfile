FROM eclipse-temurin:21-jdk

# Install OpenSSH Server
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Max-FutureTime=100000000 update --allow-insecure-repositories && apt-get install -y --allow-unauthenticated openssh-server sudo

# Create a user for deployment
RUN useradd -m -s /bin/bash deployer && \
    echo "deployer:password" | chpasswd && \
    adduser deployer sudo

# Configure SSH
RUN mkdir /var/run/sshd
# Allow password authentication (usually enabled by default but just in case)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
