#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# Configuration
URL=${WORDPRESS_URL:-http://localhost:8080}
TITLE=${WORDPRESS_TITLE:-"WP-CLI Test Lab"}
ADMIN_USER=${WORDPRESS_ADMIN_USER:-admin}
ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD:-adminpassword}
ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL:-admin@example.com}

echo "--- DEBUG: Current environment variables ---"
echo "URL: $URL"
echo "TITLE: $TITLE"
echo "--- END DEBUG ---"

# Load environment variables from .env if it exists
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Waiting for database to be ready..."
until docker compose exec --user root db mysqladmin ping -h"localhost" -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD --silent; do
    printf "."
    sleep 2
done

echo -e "\nDatabase is ready! Waiting additional 5s for stability..."
sleep 5

# Check if WordPress is already installed
echo "Checking if WordPress is installed..."
if docker compose exec --user root cli php -d memory_limit=512M /usr/local/bin/wp core is-installed --allow-root 2>/dev/null; then
    echo "WordPress is already installed."
else
    echo "Installing WordPress..."
    echo "--- Pulling WordPress Core ---"
    docker compose exec --user root cli php -d memory_limit=512M /usr/local/bin/wp core download --allow-root --force --version=6.4.3
    
    echo "--- Checking directory contents after download ---"
    docker compose exec --user root cli ls -la /var/www/html
    
    echo "--- Creating wp-config.php ---"
    docker compose exec --user root cli php -d memory_limit=512M /usr/local/bin/wp config create --allow-root \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="db" \
        --force
    
    echo "--- Running Installation ---"
    docker compose exec --user root cli php -d memory_limit=512M /usr/local/bin/wp core install --allow-root \
        --url="$URL" \
        --title="$TITLE" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_EMAIL"
    
    echo "WordPress installed successfully!"
fi

# Example: Install a plugin
echo "Installing Akismet plugin..."
docker compose exec --user root cli php -d memory_limit=512M /usr/local/bin/wp plugin install akismet --activate --allow-root

echo "Setup complete!"
echo "URL: $URL"
echo "Admin User: $ADMIN_USER"
echo "Admin Password: $ADMIN_PASSWORD"
