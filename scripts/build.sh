#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "Starting Java Build Process"
echo "----------------------------------------------------"

WORKSPACE_DIR="/var/jenkins_home/workspace/manual_build"

# Clean and Create Workspace
rm -rf $WORKSPACE_DIR
mkdir -p $WORKSPACE_DIR
cd $WORKSPACE_DIR

echo "Cloning from Gitblit..."
# Using the internal docker network address for gitblit
# Note: This requires the repo 'java_test.git' to exist in Gitblit
git clone http://gitblit:8080/git/java_test.git .

echo "Building with Maven..."
export JAVA_HOME=$(ls -d /usr/lib/jvm/temurin-21-jdk-* 2>/dev/null | head -n 1)
if [ -z "$JAVA_HOME" ]; then
    export JAVA_HOME=$(ls -d /usr/lib/jvm/java-21-openjdk-* 2>/dev/null | head -n 1)
fi
export PATH=$JAVA_HOME/bin:$PATH
mvn clean package

echo "Build Success!"
echo "Packaging JAR..."

ARTIFACT_DIR="/var/jenkins_home/artifacts"
mkdir -p $ARTIFACT_DIR
cp target/java_test-1.0-SNAPSHOT.jar $ARTIFACT_DIR/app.jar

echo "Artifact saved to $ARTIFACT_DIR/app.jar"
echo "----------------------------------------------------"
