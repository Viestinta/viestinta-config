#!/bin/bash

# Set constants
GIT_REPO="https://github.com/Viestinta/viestinta.git"
GIT_DEV_BRANCH=develop
SCRIPT_DIR=$PWD
GIT_DIR=/git
PROD_DIR="$GIT_DIR/prod"
DEV_DIR="$GIT_DIR/dev"
VIESTINTA_DIR=/etc/viestinta

# Viestinta install script

# Create git directory
mkdir -v $GIT_DIR

# Create prod and dev directories
mkdir -v $PROD_DIR
mkdir -v $DEV_DIR

# Clone GitHub repo to prod directory
cd $PROD_DIR
git clone $GIT_REPO

# Clone GitHub repo to prod directory
cd $DEV_DIR
git clone $GIT_REPO
git checkout $GIT_DEV_BRANCH

# Return to script directory
cd $SCRIPT_DIR

# Create Viestinta system directory
mkdir -v $VIESTINTA_DIR

# Create environmentfiles
cp -v ./files/viestinta.prod.env /etc/viestinta/
cp -v ./files/viestinta.dev.env /etc/viestinta/

# Copy the Systemd Unit file to correct location 
cp -v ./files/viestinta-docker.service /lib/systemd/system/

# Reload Systemd daemon
systemctl daemon-reload
