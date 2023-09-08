#!/bin/sh

sudo swapon --show
free -h
df -h

sudo fallocate -l 4G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

sudo swapon --show
free -h
df -h
