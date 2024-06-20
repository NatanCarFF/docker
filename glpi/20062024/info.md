acessar arquivo de configuração do glpi e definir a pasta pública

definir os cookies como = 1

timezone:
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -h glpi-db -u root -p mysql
mysql -h glpi-db -u root -p
GRANT SELECT ON mysql.time_zone_name TO 'glpi_user'@'%';
FLUSH PRIVILEGES;
EXIT;
