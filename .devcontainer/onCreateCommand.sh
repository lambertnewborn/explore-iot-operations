#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail

echo "Starting On Create Command"

echo fs.inotify.max_user_instances=8192 | sudo tee -a /etc/sysctl.conf
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
echo fs.file-max = 100000 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Create k3d cluster and forwarded ports
k3d cluster delete
k3d cluster create \
-i rancher/k3s:v1.30.11-k3s1 \
-p '1883:1883@loadbalancer' \
-p '8883:8883@loadbalancer'

echo "Ending On Create Command"
