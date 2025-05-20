#!/bin/bash
sudo apt update
sudo apt install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo ufw allow 'Nginx Full'

echo "Nginx installation completed. You can access it at http://<your-server-ip>." | sudo tee -a /var/www/html/index.html