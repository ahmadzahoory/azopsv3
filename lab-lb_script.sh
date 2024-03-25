#!/bin/bash
sudo apt-get -y update
sudo apt-get install -y apache2 wget unzip
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get -y update
sudo apt-get install -y php8.2
sudo apt-get install -y stress-ng
cd /var/www/html/
sudo rm index.html
sudo wget https://raw.githubusercontent.com/ahmadzahoory/azopsv3/master/lab-lb-code.zip
sudo unzip lab-lb-code.zip
sudo systemctl restart apache2.service
