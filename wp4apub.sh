#!/bin/bash

#This script installs WordPress on an Ubuntu server running Apache
#This script CAN is intended to be ran immediately after running the script apa4ubu.sh (from the apa4ubu repo) to set up Apache on Ubuntu


#installs WordPress PHP mysql server
sudo apt update
sudo apt upgrade
sudo apt install wordpress php libapache2-mod-php mysql-server php-mysql
#Creates a symbolic link from default installation path of wordpress: /usr/share/wordpress to the path intended for installation of content management systems
sudo ln -s /usr/share/wordpress /var/www/html/wordpress

#Create a mysql pw for root. Creates the wordpress database. Adds a new mysql user/pw for wordpress.
echo "Enter a mysql pw to use for root"
read newpw
echo "Enter a mysql pw to use for wordpress"
read wppw
mysql -u root
SET PASSWORD FOR 'root'@'localhost' = PASSWORD("$newpw");
CREATE DATABASE wordpress;
CREATE USER 'wordpress' IDENTIFIED BY "$wppw"
#Granst proper privledges to wordpress sql user
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,ALTER
ON wordpress.*
TO wordpress@localhost
IDENTIFIED BY '<your-password>';
FLUSH PRIVILEGES;
quit
#Creates and modifies wordpress config file
touch /etc/apache2/sites-available/wordpress.conf
