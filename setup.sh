#!/bin/bash

# Configuration
URL=${WORDPRESS_URL:-http://localhost:8080}
TITLE=${WORDPRESS_TITLE:-"WP-CLI Test Lab"}
ADMIN_USER=${WORDPRESS_ADMIN_USER:-admin}
ADMIN_PASSWORD=${WORDPRESS_ADMIN_PASSWORD:-adminpassword}
ADMIN_EMAIL=${WORDPRESS_ADMIN_EMAIL:-admin@example.com}

# Load environment variables from .env if it exists
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

echo "Waiting for database to be ready..."
until docker compose exec db mysqladmin ping -h"localhost" -u$WORDPRESS_DB_USER -p$WORDPRESS_DB_PASSWORD --silent; do
    printf "."
    sleep 2
done

echo -e "\nDatabase is ready! Waiting additional 5s for stability..."
sleep 5

# Check if WordPress is already installed
if docker compose exec cli php -d memory_limit=512M /usr/local/bin/wp core is-installed --allow-root 2>/dev/null; then
    echo "WordPress is already installed."
else
    echo "Installing WordPress..."
    docker compose exec cli php -d memory_limit=512M /usr/local/bin/wp core download --allow-root --force
    docker compose exec cli php -d memory_limit=512M /usr/local/bin/wp config create --allow-root \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$WORDPRESS_DB_PASSWORD" \
        --dbhost="db" \
        --force
    
    docker compose exec cli php -d memory_limit=512M /usr/local/bin/wp core install --allow-root \
        --url=$URL \
        --title="$TITLE" \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL
    
    echo "WordPress installed successfully!"
fi

# Example: Install a plugin
echo "Installing Akismet plugin..."
docker compose exec cli php -d memory_limit=512M /usr/local/bin/wp plugin install akismet --activate --allow-root

echo "Setup complete!"
echo "URL: $URL"
echo "Admin User: $ADMIN_USER"
echo "Admin Password: $ADMIN_PASSWORD"
