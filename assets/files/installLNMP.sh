#!/bin/bash

sudo add-apt-repository universe

#添加mysql用户与用户组
sudo groupadd mysql
sudo useradd -g mysql mysql -m
temp=$(cat /etc/group | grep 'aid_inet:x:'),mysql
echo $temp
sudo sed -i "s/aid_inet:x:.*$/${temp}/g" /etc/group
unset temp

#安装
sudo apt install -y vim htop nginx mysql-server php php-fpm wget lsof zip

#修改配置文件与下载wordpress
sudo sed -i '/http {/ainclude /www/nginx/conf/*.conf;' /etc/nginx/nginx.conf
sudo mkdir /www
sudo mkdir /www/nginx
sudo mkdir /www/nginx/conf
sudo mkdir /www/wwwroot
sudo mkdir /www/wwwlogs
sudo wget -O /www/wwwroot/wordpress_latest.tar.gz http://wordpress.org/latest.tar.gz
sudo tar -xzvf /www/wwwroot/wordpress_latest.tar.gz -C /www/wwwroot/
#设置权限
chown -R wordpress wordpress/
chgrp -R wordpress wordpress/

temp=#$(cat /etc/mysql/mysql.conf.d/mysqld.cnf | grep 'bind-address')
echo $temp
sudo sed -i "s/bind-address.*$/${temp}/g" /etc/mysql/mysql.conf.d/mysqld.cnf
unset temp

sudo service nginx start
sudo service mysql start
sudo service php7.0-fpm start
#sudo vim /etc/group
sudo systemctl enable nginx
sudo systemctl enable mysql
sudo systemctl enable php7.0-fpm

create user wordpress IDENTIFIED by '123456';
create database wordpress;
grant select,insert,update,delete on wordpress.* to wordpress;