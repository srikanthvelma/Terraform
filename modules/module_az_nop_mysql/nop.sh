#!/bin/bash
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb;
sudo dpkg -i packages-microsoft-prod.deb;
sudo apt-get update;
sudo apt-get install -y apt-transport-https aspnetcore-runtime-7.0;
cd / && sudo mkdir -p /var/www/nopCommerce;
cd /var/www/nopCommerce;
sudo wget https://github.com/nopSolutions/nopCommerce/releases/download/release-4.60.2/nopCommerce_4.60.2_NoSource_linux_x64.zip;
sudo apt-get install unzip -y;
sudo unzip /var/www/nopCommerce/nopCommerce_4.60.2_NoSource_linux_x64.zip;
sudo mkdir /var/www/nopCommerce/bin;
sudo mkdir /var/www/nopCommerce/logs;
sudo chgrp -R www-data /var/www/nopCommerce/;
sudo chown -R www-data /var/www/nopCommerce/;
sudo cp ~/nop.service /etc/systemd/system/nopCommerce.service;
sudo systemctl start nopCommerce.service;
sudo systemctl enable nopCommerce.service;