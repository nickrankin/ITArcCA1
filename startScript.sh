#!/bin/bash
echo "[ca1-log] Start deploying components and server"
apt update -y
echo "[ca1-log] Install JDK"
sudo apt install openjdk-21-jdk -y
echo "[ca1-log] Install Maven"
sudo apt install maven -y
echo "[ca1-log] Install Git"
sudo apt install git -y
echo "[ca1-log] Install Python components"
apt install software-properties-common -y
echo "[ca1-log] Install Ansible"
sudo sudo add-apt-repository --yes --update ppa:ansible/ansible -y
sudo apt install ansible -y
echo "[ca1-log] Configure Ansible Users"
sudo useradd ansible-user
echo "[ca1-log] Cloning project from Github"
git clone https://github.com/nickrankin/CA1-Web-Services.git
cd ./CA1-Web-Services/
echo "[ca1-log] Start Spring project"
mvn spring-boot:run
