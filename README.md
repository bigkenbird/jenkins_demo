# Jenkins + Gitblit + Java 21 Deployment Demo

This project sets up a Docker Compose environment with Jenkins, Gitblit, and a connection to a Java 21 production environment.

## Components

1.  **Jenkins**: Based on `jenkins/jenkins:lts-jdk17`, customized with Java 21, Maven, and `sshpass`.
2.  **Gitblit**: `jbbodart/gitblit`, hosting a pre-loaded `helloworld` git repository.
3.  **Java-Prod-Env**: `eclipse-temurin:21`, running an SSH server for deployment.

## How to Run

1.  Start the containers:
    ```bash
    docker-compose up -d --build
    ```

2.  Access services:
    *   **Jenkins**: [http://localhost:8080](http://localhost:8080)
    *   **Gitblit**: [http://localhost:8081](http://localhost:8081)
        *   Default credentials: `admin` / `admin`
    *   **Prod Environment**: Access via SSH on port `2222` (user `deployer`, password `password`).

## Scripts inside Jenkins

Two scripts are pre-loaded into the Jenkins container at `/var/scripts/`:

1.  **Build Script** (`/var/scripts/build.sh`):
    *   Clones the `helloworld` repository from Gitblit.
    *   Builds the project using Maven and Java 21.
    *   Saves the artifact to `/var/jenkins_home/artifacts`.

2.  **Deploy Script** (`/var/scripts/deploy.sh`):
    *   Checks for the built artifact.
    *   Uses `scp` to copy the JAR to the `java-prod-env` container.
    *   Uses `ssh` to start the application remotely.

## Usage in Jenkins

1.  Create a **Freestyle Project** or **Pipeline**.
2.  Add a **Build Step** -> **Execute Shell**.
3.  Run the build using:
    ```bash
    /var/scripts/build.sh
    ```
4.  Add another build step or separate job to deploy:
    ```bash
    /var/scripts/deploy.sh
    ```

## Development

The source code is located in `src/`.
Any changes there must be pushed to the Gitblit repository inside the container to be picked up by Jenkins.
(Currently, the repo is pre-seeded on startup).
