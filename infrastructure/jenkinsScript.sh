#!/bin/bash



# Add Jenkin's repository key to the system

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg

sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'



# Update package repository

sudo apt update -y



# Install Jenkins' dependencies

sudo apt install openjdk-11-jdk -y



# Install Jenkins

sudo apt install jenkins -y


# Install AWS CLI and configure
sudo apt install awscli -y

# Start and enable Jenkins

sudo systemctl start jenkins.service

sudo systemctl enable jenkins.service



# Open Jenkins port

sudo ufw allow 8080