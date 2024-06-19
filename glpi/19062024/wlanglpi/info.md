Para definir o hostname do seu banco de dados como `wlandb`, você precisa ajustar o arquivo `docker-compose.yml` e garantir que seu GLPI esteja configurado para usar esse hostname. Aqui está como você pode fazer isso:

### Docker Compose

Atualize seu arquivo `docker-compose.yml` para definir o hostname do serviço de banco de dados e garanta que o GLPI use esse hostname:

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
      - glpi_data:/var/www/html/files
    depends_on:
      - db
    environment:
      GLPI_DB_HOST: wlandb
      GLPI_DB_USER: glpi
      GLPI_DB_PASSWORD: glpi_password
      GLPI_DB_NAME: glpi

volumes:
  db_data:
  glpi_data:
```

### Dockerfile para GLPI com Debian 12 e configurações de segurança

O Dockerfile em si não precisa de muitas alterações além do que já fizemos. Mas, para garantir que todas as configurações estejam corretas, podemos adicionar a configuração do banco de dados diretamente no GLPI durante a inicialização.

Aqui está o Dockerfile atualizado:

```Dockerfile
# Use a imagem oficial do Debian 12 como base
FROM debian:12

# Etiqueta do mantenedor
LABEL maintainer="infraestrutura@wlanfibra.com.br"

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
    && apt-get clean

# Baixe e descompacte o GLPI
RUN curl -L https://github.com/glpi-project/glpi/releases/download/10.0.15/glpi-10.0.15.tgz -o /tmp/glpi.tgz \
    && tar -xzf /tmp/glpi.tgz -C /var/www/html --strip-components=1 \
    && rm /tmp/glpi.tgz

# Defina as permissões corretas
RUN chown -R www-data:www-data /var/www/html \
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

Crie um arquivo chamado `php.ini` com o seguinte conteúdo para melhorar a segurança:

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
```

### glpi.conf

Crie um arquivo chamado `glpi.conf` com o seguinte conteúdo para configurar o Apache:

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

### Passos para construir e rodar o contêiner

1. **Construa a imagem do GLPI:**
   Navegue até o diretório onde você criou os arquivos e execute:
   ```sh
   docker-compose build
   ```

2. **Inicie os contêineres:**
   Execute:
   ```sh
   docker-compose up -d
   ```

3. **Acesse o GLPI:**
   Abra seu navegador e acesse `http://localhost` para iniciar a configuração do GLPI. Use as credenciais do banco de dados conforme especificado no `docker-compose.yml`.

Com esses arquivos, você terá uma configuração GLPI 10.0.15 segura, baseada em Debian 12, com o hostname do banco de dados definido como `wlandb`. Certifique-se de ajustar as senhas e outras informações sensíveis para valores seguros se você estiver usando isso em um ambiente de produção.
