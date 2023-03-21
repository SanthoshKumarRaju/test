#!/bin/bash
sudo amazon-linux-extras install java-openjdk11
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins
systemctl enable jenkins 
systemctl start jenkins 