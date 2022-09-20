#!/bin/bash

# Run the 
sudo apt-get update

# Run the API
# java -jar /home/ubuntu/java/target/*.war

#Start the server and run the API
cd /home/ubuntu/java/target
nohup java -jar *.war </dev/null &>/dev/null &
