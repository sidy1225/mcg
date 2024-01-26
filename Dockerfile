## Use the Fedora base image
#FROM quay.io/centos/centos:stream9

## Install necessary packages
#RUN dnf -y upgrade \
#	&& dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
#	&& dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm \
#	&& dnf module list php \
#	&& dnf module enable php:remi-8.3 -y \
#	&& dnf install php php-cli php-common php-pdo php-mysqli httpd -y

## Set up Apache
#RUN systemctl enable httpd

## Expose port 80
#EXPOSE 80

## Start Apache in the foreground
#CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# Use PHP 8.3 Apache base image
FROM php:8.3-apache

# Set working directory
WORKDIR /var/www/html

# Update package lists
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql zip

# Enable Apache modules
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set recommended PHP.ini settings
RUN { \
    echo 'memory_limit = 256M'; \
    echo 'upload_max_filesize = 100M'; \
    echo 'post_max_size = 100M'; \
    echo 'max_execution_time = 600'; \
    echo 'date.timezone = "UTC"'; \
} > /usr/local/etc/php/php.ini

# Clone your Laravel application into the working directory
# Replace <your-laravel-repo-url> with the URL of your Laravel application repository
RUN git clone <your-laravel-repo-url> .

# Set permissions for Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
