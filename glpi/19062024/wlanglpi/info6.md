Peço desculpas pela confusão anterior. Vou mostrar os arquivos atualizados com todas as configurações recomendadas pela documentação do GLPI, integrando as diretrizes de segurança, performance e configurações específicas do GLPI nos arquivos Dockerfile, php.ini e glpi.conf.

### Dockerfile

No Dockerfile, integraremos as configurações de segurança, ajustes de performance e outras recomendações específicas do GLPI:

```Dockerfile
# Use a imagem oficial do Debian 12 como base
FROM debian:12

# Etiqueta do mantenedor
LABEL maintainer="infraestrutura@wlanfibra.com.br"

# Defina o timezone do sistema operacional
ENV TZ=America/Belem

# Instale dependências e ferramentas essenciais
RUN apt-get update && apt-get install -y \
    apache2 \
    libapache2-mod-php \
    curl \
    php \
    php-cli \
    php-gd \
    php-mysql \
    php-curl \
    php-intl \
    php-ldap \
    php-apcu \
    php-imap \
    php-xmlrpc \
    php-mbstring \
    php-xml \
    php-cas \
    php-bz2 \
    php-zip \
    php-bcmath \
    php-soap \
    php-redis \
    mariadb-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    tzdata \
    && apt-get clean

# Configure o timezone do sistema
RUN ln -snf /usr/share/zoneinfo/America/Belem /etc/localtime && echo "America/Belem" > /etc/timezone

# Baixe e descompacte o GLPI
RUN curl -L https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz -o /tmp/glpi.tgz \
    && tar -xzf /tmp/glpi.tgz -C /var/www/html --strip-components=1 \
    && rm /tmp/glpi.tgz

# Crie as pastas necessárias e defina as permissões corretas
RUN mkdir -p /var/www/html/config \
    /var/www/html/files \
    /var/www/html/marketplace \
    /var/www/html/plugins \
    && chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Habilite os módulos do Apache necessários
RUN a2enmod rewrite

# Configurações de PHP recomendadas
COPY php.ini /usr/local/etc/php/

# Configurações de Apache recomendadas
COPY glpi.conf /etc/apache2/sites-available/glpi.conf
RUN a2dissite 000-default.conf && a2ensite glpi.conf

# Exponha a porta 80
EXPOSE 80

# Inicie o Apache no contêiner
CMD ["apache2-foreground"]
```

### php.ini

No arquivo php.ini, vamos integrar as configurações de segurança, performance e recomendações adicionais do GLPI:

```ini
memory_limit = 256M
upload_max_filesize = 16M
post_max_size = 16M
max_execution_time = 300
session.cookie_httponly = On
session.cookie_secure = On
display_errors = Off
log_errors = On
error_log = /var/log/php_errors.log
date.timezone = "America/Belem"

# Recomendações adicionais do GLPI
always_populate_raw_post_data = -1
default_charset = UTF-8
```

### glpi.conf

No arquivo glpi.conf, vamos configurar as diretivas do Apache conforme as recomendações do GLPI para segurança e performance:

```apache
<VirtualHost *:80>
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        Options FollowSymlinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <FilesMatch "\.ph(p[3457]?|t|tml)$">
        SetHandler "proxy:unix:/run/php/php7.4-fpm.sock|fcgi://localhost"
    </FilesMatch>

    # Desabilite listagem de diretórios
    <Directory /var/www/html>
        Options -Indexes
    </Directory>

    # Proteja arquivos sensíveis
    <FilesMatch "(?i)(\.htaccess|\.htpasswd|\.ini|\.phar|composer\.(json|lock))">
        Require all denied
    </FilesMatch>

    # Recomendações adicionais do GLPI
    ServerTokens Prod
    ServerSignature Off
</VirtualHost>
```

### Considerações Finais

Estas configurações integradas garantem que seu ambiente Docker para o GLPI esteja configurado com todas as diretrizes recomendadas pela documentação do GLPI, proporcionando segurança, performance e ajustes específicos para a aplicação. Certifique-se de ajustar outros aspectos do ambiente, como redes, volumes persistentes e variáveis de ambiente conforme necessário para seu ambiente de produção.
