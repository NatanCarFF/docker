Claro! Vamos organizar os arquivos com base nas configurações e estrutura discutidas. Aqui estão os arquivos atualizados para o Dockerfile, docker-compose.yml, php.ini e glpi.conf:

### Dockerfile

O Dockerfile define como a imagem Docker será construída. Ele instala as dependências necessárias, configura o timezone, baixa e configura o GLPI, define permissões e configurações do Apache.

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

### docker-compose.yml

O docker-compose.yml define os serviços, redes e volumes que serão usados pelo Docker. Aqui configuramos os serviços `db` (MariaDB) e `glpi` (aplicação GLPI), além dos volumes para persistência de dados.

```yaml
version: '3.8'

services:
  db:
    image: mariadb:10.5
    restart: always
    hostname: wlandb
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: glpi
      MYSQL_USER: glpi
      MYSQL_PASSWORD: glpi_password
    volumes:
      - db_data:/var/lib/mysql

  glpi:
    build: .
    ports:
      - "80:80"
    volumes:
      - glpi_files:/var/www/html/files
    depends_on:
      - db
    environment:
      GLPI_DB_HOST: wlandb
      GLPI_DB_USER: glpi
      GLPI_DB_PASSWORD: glpi_password
      GLPI_DB_NAME: glpi

volumes:
  db_data:
  glpi_files:
```

### php.ini

O arquivo php.ini contém as configurações do PHP específicas para o GLPI, incluindo ajustes de segurança e timezone.

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
```

### glpi.conf

O arquivo glpi.conf define as configurações do Apache para o GLPI, configurando o virtual host e as permissões de diretório.

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
</VirtualHost>
```

### Estrutura de Diretórios e Volumes

Na estrutura de diretórios que você deve ter no seu sistema host:

```
glpi-docker/
│
├── docker-compose.yml
├── Dockerfile
├── php.ini
├── glpi.conf
└── volumes/
    ├── db_data/
    └── glpi_files/
```

Certifique-se de que todos esses arquivos e diretórios estejam corretamente organizados no seu ambiente. Esta configuração proporcionará um ambiente Docker funcional para o GLPI, com todos os ajustes de segurança, configurações de timezone e volumes persistentes configurados conforme discutido.
