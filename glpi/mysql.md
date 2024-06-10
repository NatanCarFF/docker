Claro, aqui estão os passos para aplicar as recomendações:

1. **Configuração do diretório raiz do servidor web**:
   - Acesse o arquivo de configuração do Apache, geralmente localizado em `/etc/apache2/sites-available/000-default.conf`.
   - Dentro desse arquivo, localize a diretiva `DocumentRoot` e ajuste o caminho para apontar para o diretório público do GLPI, por exemplo: `/var/www/html/glpi/public`.
   - Salve as alterações e reinicie o Apache para que as alterações entrem em vigor.

2. **Mover diretórios fora do diretório raiz do servidor web**:
   - Crie os diretórios fora do diretório raiz do servidor web, por exemplo: `/var/glpi_data/files`, `/var/glpi_data/config`, etc.
   - Mova os conteúdos dos diretórios correspondentes no diretório raiz do GLPI para os novos diretórios criados.
   - Atualize as configurações do GLPI para refletir os novos caminhos dos diretórios. Isso geralmente é feito no arquivo de configuração do GLPI.

3. **Configuração da diretiva PHP "session.cookie_httponly"**:
   - Edite o arquivo de configuração do PHP, geralmente localizado em `/etc/php/8.2/apache2/php.ini`.
   - Procure pela diretiva `session.cookie_httponly` e defina-a como `On`.
   - Salve o arquivo e reinicie o Apache para aplicar as alterações.

4. **Permitir acesso ao banco de dados do fuso horário**:
   - Acesse o MySQL como um usuário com permissões administrativas.
   - Execute o comando SQL para permitir o acesso ao banco de dados do fuso horário:
     ```
     GRANT SELECT ON mysql.time_zone_name TO 'seu_usuario'@'seu_servidor';
     FLUSH PRIVILEGES;
     ```
   - Substitua `'seu_usuario'` e `'seu_servidor'` pelos valores apropriados.

Certifique-se de fazer backup de todos os arquivos e configurações importantes antes de fazer essas alterações. Se precisar de mais orientações sobre algum dos passos, estou à disposição para ajudar!
