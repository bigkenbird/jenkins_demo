#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "Starting Java Deploy Process"
echo "----------------------------------------------------"

ARTIFACT_PATH="/var/jenkins_home/artifacts/java_app.tar.gz"

if [ ! -f "$ARTIFACT_PATH" ]; then
    echo "Error: Artifact not found at $ARTIFACT_PATH. Run build.sh first!"
    exit 1
fi

TARGET_USER="deployer"
TARGET_PASS="password"
TARGET_HOST="java-prod-env"
TARGET_DIR="/home/deployer/java_app"

echo "Deploying artifact to $TARGET_HOST..."

# Create the target directory
sshpass -p "$TARGET_PASS" ssh -o StrictHostKeyChecking=no "$TARGET_USER@$TARGET_HOST" "mkdir -p $TARGET_DIR"

# Use sshpass to send password non-interactively
# Disable host key checking for automated environment
sshpass -p "$TARGET_PASS" scp -o StrictHostKeyChecking=no "$ARTIFACT_PATH" "$TARGET_USER@$TARGET_HOST:$TARGET_DIR/app.tar.gz"

echo "Artifact transferred successfully."

echo "Starting application on remote server..."
sshpass -p "$TARGET_PASS" ssh -o StrictHostKeyChecking=no "$TARGET_USER@$TARGET_HOST" \
    "cd $TARGET_DIR && tar -xzf app.tar.gz && nohup /opt/java/openjdk/bin/java -jar app.jar > /tmp/app.log 2>&1 &"

echo "Deployment complete! Application is running on $TARGET_HOST."
echo "----------------------------------------------------"
