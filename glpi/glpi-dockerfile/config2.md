Claro, aqui está o passo a passo para abordar o tópico 1, que trata da configuração do diretório raiz do servidor web para garantir a segurança:

1. **Identifique o diretório raiz do servidor web:**
   - O diretório raiz do servidor web é o local onde os arquivos do seu site ou aplicativo estão armazenados. No seu caso, parece ser "/var/www/html/glpi".

2. **Identifique os diretórios que não devem ser acessíveis publicamente:**
   - Antes de reconfigurar o servidor web, identifique os diretórios que contêm informações sensíveis ou que não devem ser acessíveis publicamente. No caso do GLPI, isso inclui os diretórios de configuração, arquivos de log e outros diretórios que não são destinados ao acesso público.

3. **Reconfigure o servidor web para restringir o acesso aos diretórios sensíveis:**
   - Dependendo do servidor web que você está usando (no seu caso, Apache), você precisará editar o arquivo de configuração apropriado. Geralmente, este arquivo é chamado de "httpd.conf" ou "apache2.conf", e está localizado em algum lugar como "/etc/apache2/".

4. **Edite o arquivo de configuração do Apache:**
   - Abra o arquivo de configuração do Apache em um editor de texto. Você pode precisar de permissões de superusuário para editar este arquivo, então use o comando `sudo` se necessário. Por exemplo:
     ```
     sudo nano /etc/apache2/apache2.conf
     ```

5. **Configure as permissões de acesso aos diretórios:**
   - Dentro do arquivo de configuração do Apache, localize a seção que define as permissões de acesso aos diretórios. Isso geralmente é feito usando a diretiva `Directory` seguida pelo caminho do diretório e as configurações de acesso. Por exemplo:
     ```
     <Directory /var/www/html/glpi/files/_log>
         Require all denied
     </Directory>
     ```

6. **Repita o passo anterior para todos os diretórios sensíveis:**
   - Edite o arquivo de configuração do Apache para cada diretório sensível, negando o acesso público a esses diretórios.

7. **Salve e feche o arquivo de configuração:**
   - Depois de fazer as alterações necessárias, salve o arquivo e feche o editor de texto.

8. **Reinicie o servidor web:**
   - Após editar o arquivo de configuração do Apache, reinicie o servidor web para que as alterações entrem em vigor. Você pode fazer isso usando o seguinte comando:
     ```
     sudo service apache2 restart
     ```

9. **Verifique as configurações:**
   - Após reiniciar o servidor web, verifique se as configurações foram aplicadas corretamente. Tente acessar os diretórios que você restringiu para garantir que não seja mais possível acessá-los publicamente.

Ao seguir este passo a passo, você deverá ter reconfigurado com segurança o diretório raiz do servidor web para garantir que os diretórios sensíveis não sejam acessíveis publicamente. Certifique-se sempre de fazer backup de quaisquer arquivos de configuração antes de fazer alterações.
