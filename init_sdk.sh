#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")
IMAGE_NAME=$(cat "$SCRIPT_DIR"/docker_image_tag)
IMAGE_FULL_NAME=xianzilu/"$IMAGE_NAME"

sudo apt update
sudo apt install docker.io -y
sudo usermod -aGdocker "$USER"
sudo docker pull "$IMAGE_FULL_NAME"
sudo docker tag "$IMAGE_FULL_NAME" "$IMAGE_NAME"

read -p "Need to reboot to complete the initialization, do you wish to proceed? (yes/no)" answer
if [ "$answer" = "yes" ]; then
    sudo reboot
else
    echo "Skipped rebooting, you need to reboot manually, before running docker commands or the ppsdk scripts without root privilege."
fi

