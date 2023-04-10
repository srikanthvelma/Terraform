#!/bin/bash
sudo apt update
sudo apt install openjdk-17-jdk -y
sudo apt install maven -y
sudo cp /tmp/spc.service /etc/systemd/system/spc.service
git clone https://github.com/spring-projects/spring-petclinic.git
cd spring-petclinic
./mvnw package
sudo systemctl daemon-reload
sudo systemctl start spc.service
sudo systemctl enable spc.service