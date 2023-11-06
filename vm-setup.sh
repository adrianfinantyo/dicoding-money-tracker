#!/bin/sh

echo "Starting VM setup..."

# Install docker

## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

## Install the Docker packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Add user to docker group
sudo usermod -aG docker ${USER}

## Verify that Docker Engine is installed correctly by running the hello-world image.
sudo docker run hello-world

# Install git
echo "Installing git..."
sudo apt-get install -y git

# Clone the repo
echo "Cloning the repo..."
git clone https://github.com/adrianfinantyo/dicoding-money-tracker.git


# Close session
echo "VM setup finished. Closing session..."
exit