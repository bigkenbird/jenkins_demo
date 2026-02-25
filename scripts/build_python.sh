#!/bin/bash
set -e

echo "----------------------------------------------------"
echo "Starting Python Build Process"
echo "----------------------------------------------------"

WORKSPACE_DIR="/var/jenkins_home/workspace/manual_build_python"

# Clean and Create Workspace
rm -rf $WORKSPACE_DIR
mkdir -p $WORKSPACE_DIR
cd $WORKSPACE_DIR

echo "Cloning from Gitblit..."
# Using the internal docker network address for gitblit
git config --global http.sslVerify false
git clone https://admin:admin@gitblit:8443/r/python_test.git .

echo "Setting up Virtual Environment..."
python3 -m venv venv
source venv/bin/activate

echo "Installing Requirements..."
pip install -r requirements.txt || echo "No dependencies to install"

echo "Packaging Application..."
ARTIFACT_DIR="/var/jenkins_home/artifacts"
mkdir -p $ARTIFACT_DIR
tar -czvf $ARTIFACT_DIR/python_app.tar.gz .

echo "Artifact saved to $ARTIFACT_DIR/python_app.tar.gz"
echo "----------------------------------------------------"
