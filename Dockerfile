## Use Fedora base image with httpd
#FROM centos:stream9
#
## Install httpd, PHP, and required extensions
#RUN dnf -y update && \
#    dnf -y install httpd php php-cli php-json php-xml php-mbstring && \
#    dnf clean all
#
## Install Composer globally
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
#    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
#    rm composer-setup.php
#
## Set up Apache document root
#RUN mkdir -p /var/www/html
#
## Copy your PHP application files to the container
#COPY . /var/www/html
#
## Expose the port
#EXPOSE 8080
#
## Start httpd service
#CMD ["httpd", "-D", "FOREGROUND"]


## Use a PHP with Apache base image
#FROM fedora:latest

## Install necessary PHP extensions and Apache
#RUN yum -y update && yum -y install \
#    libapache2-mod-php \
#    # Other necessary packages here

## Copy your PHP files into the container
#COPY ./your-php-files /var/www/html

## Set Apache configurations if needed
## ...

## Expose port
#EXPOSE 80

## Start Apache
#CMD ["apache2ctl", "-D", "FOREGROUND"]

# Use the Fedora base image
FROM quay.io/centos/centos:stream9

# Install necessary packages
#RUN dnf -y 
RUN dnf -y upgrade \
	&& dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm \
	&& dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm \
	&& dnf module list php \
	&& dnf module enable php:remi-8.3 -y \
	&& dnf install php php-cli php-common php-pdo php-mysqli httpd -y

# Set up Apache
RUN systemctl enable httpd

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
