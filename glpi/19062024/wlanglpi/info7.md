Aqui estão os arquivos atualizados sem os comentários:

### Dockerfile

```Dockerfile
FROM debian:12

LABEL maintainer="infraestrutura@wlanfibra.com.br"

ENV TZ=America/Belem

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

RUN ln -snf /usr/share/zoneinfo/America/Belem /etc/localtime && echo "America/Belem" > /etc/timezone

RUN curl -L https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz -o /tmp/glpi.tgz \
    && tar -xzf /tmp/glpi.tgz -C /var/www/html --strip-components=1 \
    && rm /tmp/glpi.tgz

RUN mkdir -p /var/www/html/config \
    /var/www/html/files \
    /var/www/html/marketplace \
    /var/www/html/plugins \
    && chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

RUN a2enmod rewrite

COPY php.ini /usr/local/etc/php/

COPY glpi.conf /etc/apache2/sites-available/glpi.conf
RUN a2dissite 000-default.conf && a2ensite glpi.conf

EXPOSE 80

CMD ["apache2-foreground"]
```

### php.ini

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

always_populate_raw_post_data = -1
default_charset = UTF-8
```

### glpi.conf

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

    <Directory /var/www/html>
        Options -Indexes
    </Directory>

    <FilesMatch "(?i)(\.htaccess|\.htpasswd|\.ini|\.phar|composer\.(json|lock))">
        Require all denied
    </FilesMatch>

    ServerTokens Prod
    ServerSignature Off
</VirtualHost>
```

Esses arquivos estão agora sem os comentários, mantendo apenas as configurações necessárias para a construção e execução do ambiente Docker para o GLPI, conforme as recomendações de segurança e configurações específicas da aplicação.
