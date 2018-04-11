#!/bin/bash
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update
sudo apt-get -y upgrade
# arret de nginx si actif
sudo service nginx stop
# on desinstall , on purge et on supprime tout fichier residuel
sudo apt purge nginx*
sudo rm -Rf /etc/nginx/
#on reinstall nginx
sudo apt install nginx
nginx -v
sudo service nginx start
#configuration de nginx
cd /etc/nginx/
sudo wget https://github.com/mainardrenaud/installDevEnv/blob/master/nginx.conf
cd /etc/nginx/sites-available/
#configuration nginx server multigest-back
sudo wget https://raw.githubusercontent.com/mainardrenaud/installDevEnv/master/multigest-back
sudo ln -s /etc/nginx/sites-available/multigest-back /etc/nginx/sites-enabled/multigest-back
#suppression de la version php existante
sudo apt purge php7* && apt-get autoremove && apt-get autoclean
#installation php7.2
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install php7.2 php7.2-fpm php7.2-mysql php7.2-curl php7.2-xml php7.2-json php7.2-gd php7.2-msgpack php7.2-memcached php7.2-intl php7.2-sqlite3 php7.2-gmp php7.2-geoip php7.2-mbstring php7.2-redis php7.2-xml php7.2-zip php7.2-cli php7.2-common php7.2-mysql php7.2-readline php7.2-igbinary
#configuration php7.2
#cd /etc/php/7.2/fpm/
#sudo wget https://raw.githubusercontent.com/mainardrenaud/installDevEnv/master/php-fpm.conf
#sudo wget https://raw.githubusercontent.com/mainardrenaud/installDevEnv/master/php.ini
#cd /etc/php/7.2/fpm/pool.d/
#sudo wget https://raw.githubusercontent.com/mainardrenaud/installDevEnv/master/www.conf
#demarrage des service php et nginx
sudo service php7.2-fpm start
sudo service nginx start
#création du repertoire de dev passer en parametre dans multigest-back
sudo mkdir /mnt/e/developpements/multigest-back;
cd /mnt/e/developpements/multigest-back
sudo wget https://raw.githubusercontent.com/mainardrenaud/installDevEnv/master/infos.php
curl -Is http://localhost :8081 
#installation mariadb
sudo apt purge lamp-server^ mariadb* mysql*
sudo apt-get autoremove && sudo apt-get autoclean
sudo apt-get install mariadb*
sudo service mysql start
sudo mysql_secure_installation
#installation de composer
cd /mnt/e/developpements/
sudo php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php
sudo php -r "unlink('composer-setup.php');"
sudo mv composer.phar composer
#installation de git pour install de sf4
sudo apt-get install git
#installation symfony4
cd /mnt/e/developpements
sudo ./composer create-project symfony/skeleton multigest-back
sudo mkdir multigest-back/logs

