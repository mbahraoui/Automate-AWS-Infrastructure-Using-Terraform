#!/bin/bash
sudo yum update -y 
sudo amazon-linux-extras install docker -y
sudo systemctl start docker 
sudo systemctl enable docker
sudo usermod -a -G docker $USER
docker run -p 80:80 nginx