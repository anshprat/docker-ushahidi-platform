#!/bin/bash

/usr/bin/mysqld_safe &
 sleep 10s

 mysqladmin -u root password mysqlpsswd
 mysqladmin -u root -pmysqlpsswd reload
 mysqladmin -u root -pmysqlpsswd create ushahidi

 echo "GRANT ALL ON ushahidi.* TO ushahidiuser@localhost IDENTIFIED BY 'ushahidipasswd'; flush privileges; " | mysql -u root -pmysqlpsswd

 cd /var/www/
 git clone https://github.com/ushahidi/platform.git
 git submodule update --init --recursive
 chown -R www-data:www-data /var/www/platform
 mv /var/www/platform/httpdocs/template.htaccess /var/www/platform/httpdocs/.htaccess
 chmod 770 platform/application/cache
 chmod 770 platform/application/logs
 chmod 770 platform/application/media/uploads
 chmod 770 platform/httpdocs/.htaccess
 rm -R /var/www/html
 a2enmod rewrite
 a2enmod headers


killall mysqld
sleep 10s
