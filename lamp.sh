#!/bin/bash -e
clear
echo "============================================"
echo "LAMP Install Script"
echo "============================================"
echo "Database Password (MySQL User Password):"
read -s dbpass
echo "run install? (y/n)"
read -e run
if [ "$run" == n ] ; then
exit
else
echo "============================================"
echo "LAMP stack is being installed."
echo "============================================"
# install apache
sudo apt-get install apache2

# install PHP
sudo apt-get install php5 libapache2-mod-php5 php5-mysql

# install MySQL
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $dbpass"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $dbpass"
sudo apt-get -y install mysql-server

#install Adminer
sudo mkdir /usr/share/adminer
sudo wget "http://www.adminer.org/latest.php" -O /usr/share/adminer/latest.php
sudo ln -s /usr/share/adminer/latest.php /usr/share/adminer/adminer.php
echo "Alias /adminer.php /usr/share/adminer/adminer.php" | sudo tee /etc/apache2/conf-available/adminer.conf
sudo a2enconf adminer.conf
sudo service apache2 restart

echo "========================="
echo "Installation is complete."
echo "========================="
fi
