Instalar extensões 

apt-get install apache2 php php-curl php-gd php-cli php-mbstring php-mysql php-xml php-ldap openssl php-intl php-zip php-bz2 -y 
apt-get install mysql-server -y 

instalação GLPI

cd /tmp
wget https://github.com/glpi-project/glpi/...
tar -xvzf glpi-10.0.0-rc1.tgz
cp -Rf glpi /var/www/html

Permissões para a pasta do GLPI

chmod 775 /var/www/html/* -Rf
chown www-data. /var/www/html/* -Rf

Criação do banco de dados do GLPI

mysql -uroot -p
create database glpi10;
create user 'glpi'@'localhost' identified by 'Glpi@2022';
grant all privileges on nome_banco.* to 'user'@'localhost';
quit;

desabilitar a configuração padrão do Apache
a2dissite 000-default

criar um novo arquivo de configuração para o GLPi:
sudo nano /etc/apache2/sites-available/glpi.conf

Configuração  no primeiro comentário fixado

habilitar a configuração criada
sudo a2ensite glpi.conf
sudo a2enmod rewrite

Reiniciar serviço do Apache

systemctl restart apache2.service
