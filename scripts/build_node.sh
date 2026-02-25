#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "Starting Node.js Build Process"
echo "----------------------------------------------------"

WORKSPACE_DIR="/var/jenkins_home/workspace/manual_build_node"

# Clean and Create Workspace
rm -rf $WORKSPACE_DIR
mkdir -p $WORKSPACE_DIR
cd $WORKSPACE_DIR

echo "Cloning from Gitblit..."
# Using the internal docker network address for gitblit
git config --global http.sslVerify false
git clone https://admin:admin@gitblit:8443/r/node_test.git .

echo "Installing Node Dependencies..."
npm install || echo "No package.json or dependencies found."

echo "Packaging Application..."
ARTIFACT_DIR="/var/jenkins_home/artifacts"
mkdir -p $ARTIFACT_DIR
tar -czvf $ARTIFACT_DIR/node_app.tar.gz .

echo "Artifact saved to $ARTIFACT_DIR/node_app.tar.gz"
echo "----------------------------------------------------"
