#!/bin/sh
sudo apt update
sudo apt -y upgrade
sudo apt install -y apache2 wget unzip
cd /var/www/html/
sudo rm index.html
sudo wget https://raw.githubusercontent.com/ahmadzahoory/azopsv3/master/lab-mon-code-l.zip
sudo unzip lab-mon-code-l.zip
sudo systemctl restart apache2.service
#End
