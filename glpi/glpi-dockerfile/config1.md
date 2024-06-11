Parece que você precisa resolver alguns requisitos ausentes no GLPI 10.0.15. Aqui estão algumas etapas para abordar esses requisitos:

1. **Configuração do diretório raiz do servidor web:**
   - O diretório raiz do servidor web não está seguro, pois permite acesso a arquivos não públicos. Você deve configurar o servidor web para restringir o acesso a esses diretórios. Consulte a documentação de instalação para obter mais detalhes sobre como fazer isso.

2. **Definição da diretiva PHP "session.cookie_httponly":**
   - Configure a diretiva PHP "session.cookie_httponly" como "on" para evitar que scripts do lado do cliente acessem os valores dos cookies.

3. **64 bits de inteiros:**
   - Tanto o sistema operacional quanto o PHP estão usando inteiros de 64 bits. Certifique-se de que seu aplicativo esteja preparado para lidar com inteiros de 64 bits, se necessário.

4. **Acesso ao banco de dados de fuso horário não permitido:**
   - Ative o acesso ao banco de dados de fuso horário no MySQL para permitir que o GLPI acesse as informações de fuso horário necessárias.

5. **Módulos PHP ausentes:**
   - Verifique se os módulos PHP "bz2" e "zip" estão ausentes. Dependendo das funcionalidades necessárias para o GLPI, você pode precisar instalá-los.

6. **Diretórios GLPI:**
   - Os diretórios do GLPI devem ser movidos para fora do diretório raiz do servidor web, exceto se o diretório raiz for "/var/www/html/glpi/public". Confirme se isso está configurado corretamente.

7. **Outras extensões PHP:**
   - Certifique-se de que as extensões PHP necessárias, como "exif" e "ldap", estejam instaladas e configuradas corretamente.

8. **Atenção aos detalhes de configuração:**
   - Verifique se todas as configurações e permissões estão corretas conforme especificado na documentação de instalação do GLPI.

Após realizar essas verificações e ajustes, você deve conseguir resolver os requisitos ausentes no GLPI 10.0.15 e garantir uma instalação adequada e segura. Lembre-se de sempre fazer backup dos seus dados antes de fazer alterações significativas no sistema.
