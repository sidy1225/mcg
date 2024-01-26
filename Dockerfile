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

# Use PHP 8.3.2 Apache base image
FROM php:8.3.2-apache

# Set working directory
WORKDIR /var/www/html

# Update package lists and install PDO MySQL extension
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && docker-php-ext-install pdo_mysql pdo

# Enable Apache modules
RUN a2enmod rewrite

# Expose port 80
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
