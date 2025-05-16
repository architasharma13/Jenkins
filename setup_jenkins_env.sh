#!/bin/bash

# Exit on any error
set -e

echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing Node.js and npm..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

echo "Installing PM2 globally..."
sudo npm install -g pm2
echo "PM2 version: $(pm2 -v)"

echo "Installing Apache2..."
sudo apt install -y apache2

echo "Creating static HTML page..."
echo "<!DOCTYPE html>
<html>
<head>
    <title>Hello DevOps</title>
</head>
<body>
    <h1>Hello DevOps</h1>
</body>
</html>" | sudo tee /var/www/html/index.html > /dev/null

echo "Setting permissions..."
sudo chown www-data:www-data /var/www/html/index.html

echo "Restarting Apache2 to apply changes..."
sudo systemctl restart apache2

echo "✅ Setup Complete! Visit your server IP to see 'Hello DevOps'"
