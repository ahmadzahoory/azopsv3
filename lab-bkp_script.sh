#!/bin/bash
sudo apt-get -y update
sudo apt-get install -y apache2 wget unzip
cd /var/www/html/
sudo rm index.html
sudo wget https://raw.githubusercontent.com/ahmadzahoory/azopsv3/master/lab-bkp-code-l.zip
sudo unzip lab-bkp-code-l.zip
sudo systemctl restart apache2.service
