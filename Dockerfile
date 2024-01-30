# Use PHP 8.3.2 Apache base image
FROM php:8.3.2-apache

# Set working directory
WORKDIR /var/www/html

# Update package lists and install dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql zip

# Enable Apache modules
RUN a2enmod rewrite

# Expose port 8080
EXPOSE 8080

# Start Apache
CMD ["apache2-foreground"]
