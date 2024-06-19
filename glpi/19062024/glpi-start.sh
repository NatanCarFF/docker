#!/bin/bash

#Controle da escolha de versão ou utilização da versão mais recente.
[[ ! "$VERSION_GLPI" ]] \
	&& VERSION_GLPI=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/latest | grep tag_name | cut -d '"' -f 4)

if [[ -z "${TIMEZONE}" ]]; then echo "TIMEZONE is unset"; 
else 
echo "date.timezone = \"$TIMEZONE\"" > /etc/php/8.3/apache2/conf.d/timezone.ini;
echo "date.timezone = \"$TIMEZONE\"" > /etc/php/8.3/cli/conf.d/timezone.ini;
fi

#Ativar `session.cookie_httponly`.
sed -i 's,session.cookie_httponly = *\(on\|off\|true\|false\|0\|1\)\?,session.cookie_httponly = on,gi' /etc/php/8.3/apache2/php.ini

FOLDER_GLPI=glpi/
FOLDER_WEB=/var/www/html/

#Verificar se `TLS_REQCERT` está presente.
if !(grep -q "TLS_REQCERT" /etc/ldap/ldap.conf)
then
	echo "TLS_REQCERT isn't present"
    echo -e "TLS_REQCERT\tnever" >> /etc/ldap/ldap.conf
fi

#Download e extração das fontes do GLPI.
if [ "$(ls ${FOLDER_WEB}${FOLDER_GLPI}/bin)" ];
then
	echo "GLPI is already installed"
else
	SRC_GLPI=$(curl -s https://api.github.com/repos/glpi-project/glpi/releases/tags/${VERSION_GLPI} | jq .assets[0].browser_download_url | tr -d \")
	TAR_GLPI=$(basename ${SRC_GLPI})

	wget -P ${FOLDER_WEB} ${SRC_GLPI}
	tar -xzf ${FOLDER_WEB}${TAR_GLPI} -C ${FOLDER_WEB}
	rm -Rf ${FOLDER_WEB}${TAR_GLPI}
	chown -R www-data:www-data ${FOLDER_WEB}${FOLDER_GLPI}
fi

#Adapte o servidor Apache de acordo com a versão do GLPI instalada.
## Extrair a versão local instalada.
LOCAL_GLPI_VERSION=$(ls ${FOLDER_WEB}/${FOLDER_GLPI}/version)
## Extrair o número da versão principal.
LOCAL_GLPI_MAJOR_VERSION=$(echo $LOCAL_GLPI_VERSION | cut -d. -f1)
## Remover pontos da string de versão.
LOCAL_GLPI_VERSION_NUM=${LOCAL_GLPI_VERSION//./}

## O valor alvo é o GLPI 1.0.7
TARGET_GLPI_VERSION="10.0.15"
TARGET_GLPI_VERSION_NUM=${TARGET_GLPI_VERSION//./}
TARGET_GLPI_MAJOR_VERSION=$(echo $TARGET_GLPI_VERSION | cut -d. -f1)

# Compare o valor numérico do número da versão com o número alvo.
if [[ $LOCAL_GLPI_VERSION_NUM -lt $TARGET_GLPI_VERSION_NUM || $LOCAL_GLPI_MAJOR_VERSION -lt $TARGET_GLPI_MAJOR_VERSION ]]; then
  echo -e "<VirtualHost *:80>\n\tDocumentRoot /var/www/html/glpi\n\n\t<Directory /var/www/html/glpi>\n\t\tAllowOverride All\n\t\tOrder Allow,Deny\n\t\tAllow from all\n\t</Directory>\n\n\tErrorLog /var/log/apache2/error-glpi.log\n\tLogLevel warn\n\tCustomLog /var/log/apache2/access-glpi.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf
else
  set +H
  echo -e "<VirtualHost *:80>\n\tDocumentRoot /var/www/html/glpi/public\n\n\t<Directory /var/www/html/glpi/public>\n\t\tRequire all granted\n\t\tRewriteEngine On\n\t\tRewriteCond %{REQUEST_FILENAME} !-f\n\t\n\t\tRewriteRule ^(.*)$ index.php [QSA,L]\n\t</Directory>\n\n\tErrorLog /var/log/apache2/error-glpi.log\n\tLogLevel warn\n\tCustomLog /var/log/apache2/access-glpi.log combined\n</VirtualHost>" > /etc/apache2/sites-available/000-default.conf
fi

#Adicionar tarefa agendada pelo cron e habilitar.
echo "*/2 * * * * www-data /usr/bin/php /var/www/html/glpi/front/cron.php &>/dev/null" > /etc/cron.d/glpi
#Iniciar o serviço do cron.
service cron start

#Ativação do módulo rewrite do Apache.
a2enmod rewrite && service apache2 restart && service apache2 stop

#Comando para realmente parar o Apache.
pkill -9 apache

#Inicialização do serviço Apache em primeiro plano
/usr/sbin/apache2ctl -D FOREGROUND
