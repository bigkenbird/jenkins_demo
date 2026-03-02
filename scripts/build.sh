#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "Starting Java Build Process"
echo "----------------------------------------------------"

echo "Building with Maven..."
export JAVA_HOME=$(ls -d /usr/lib/jvm/temurin-21-jdk-* 2>/dev/null | head -n 1)
if [ -z "$JAVA_HOME" ]; then
    export JAVA_HOME=$(ls -d /usr/lib/jvm/java-21-openjdk-* 2>/dev/null | head -n 1)
fi
export PATH=$JAVA_HOME/bin:$PATH
mvn clean package

echo "Build Success!"