#!/bin/bash

# Set constants
GIT_REPO="https://github.com/Viestinta/viestinta.git"
GIT_PROD_BRANCH=master
GIT_DEV_BRANCH=develop
SCRIPT_DIR=$PWD
GIT_DIR=/git
PROD_DIR="$GIT_DIR/prod"
DEV_DIR="$GIT_DIR/dev"
VIESTINTA_DIR=/etc/viestinta

# Viestinta install script

# Create git directory
mkdir -pv $GIT_DIR

# Create prod and dev directories
mkdir -pv $PROD_DIR
mkdir -pv $DEV_DIR

# Clone GitHub repo to prod directory
cd $PROD_DIR
rm -rfv $PROD_DIR/viestinta
git clone -b $GIT_PROD_BRANCH $GIT_REPO

# Clone GitHub repo to prod directory
cd $DEV_DIR
rm -rfv $DEV_DIR/viestinta
git clone -b $GIT_DEV_BRANCH $GIT_REPO

# Return to script directory
cd $SCRIPT_DIR

# Create Viestinta system directory
mkdir -pv $VIESTINTA_DIR

# Create environmentfiles
cp -v ./files/viestinta.prod.env $VIESTINTA_DIR
cp -v ./files/viestinta.dev.env $VIESTINTA_DIR

# Copy the Systemd Unit files to correct location 
cp -v ./files/viestinta-docker.service /lib/systemd/system/
cp -v ./files/viestinta-docker-dev.service /lib/systemd/system/

# Reload Systemd daemon
systemctl daemon-reload
