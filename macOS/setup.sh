#!/bin/bash

# macOS WebServer Setup Script
# This script helps set up nginx and php-fpm services on macOS

set -e

echo "=== macOS WebServer Setup ==="
echo

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Error: This script is for macOS only."
    exit 1
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing nginx and php..."
brew install nginx php

echo "Creating necessary directories..."
sudo mkdir -p /usr/local/var/www/default
sudo mkdir -p /usr/local/var/log/nginx/default
sudo mkdir -p /usr/local/etc/nginx/vhosts
sudo mkdir -p /usr/local/etc/nginx/ssl

echo "Setting permissions..."
sudo chown -R $(whoami):staff /usr/local/var/www
sudo chown -R $(whoami):staff /usr/local/var/log/nginx

echo "Creating default index files..."
cat > /usr/local/var/www/default/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>macOS WebServer</title>
</head>
<body>
    <h1>Welcome to macOS WebServer!</h1>
    <p>Your web server is running successfully.</p>
    <p><a href="info.php">PHP Info</a></p>
</body>
</html>
EOF

cat > /usr/local/var/www/default/info.php << 'EOF'
<?php
phpinfo();
?>
EOF

echo "Copying nginx configuration examples..."
cp -r nginx/examples/* /usr/local/etc/nginx/

echo "Starting services..."
brew services start nginx
brew services start php

echo
echo "=== Setup Complete ==="
echo "Web server is running at: http://localhost"
echo "Default web root: /usr/local/var/www/default"
echo
echo "Service management commands:"
echo "  Start:   brew services start nginx && brew services start php"
echo "  Stop:    brew services stop nginx && brew services stop php"
echo "  Restart: brew services restart nginx && brew services restart php"
echo
echo "Log files:"
echo "  nginx access: /usr/local/var/log/nginx/access.log"
echo "  nginx error:  /usr/local/var/log/nginx/error.log"
echo "  php-fpm:      /usr/local/var/log/php-fpm.log"