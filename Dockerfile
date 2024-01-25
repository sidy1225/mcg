# Use the Fedora base image
FROM centos:stream9

# Install necessary packages
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
