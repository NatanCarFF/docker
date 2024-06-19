Para reinstalar o Docker e o Docker Compose no seu Ubuntu, você pode seguir os passos abaixo para criar um script que automatize o processo. Este script irá remover as versões antigas do Docker e do Docker Compose, instalar as versões mais recentes disponíveis e configurar os binários corretamente.

### Passos para criar o script:

1. **Criar o script**:
   Abra um editor de texto e cole o seguinte conteúdo:

   ```bash
   #!/bin/bash

   # Remove versões antigas do Docker
   sudo apt-get remove docker docker-engine docker.io containerd runc

   # Atualiza o sistema
   sudo apt-get update

   # Instala as dependências para o Docker
   sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

   # Adiciona a chave GPG oficial do Docker
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

   # Configura o repositório estável do Docker
   echo \
   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

   # Instala o Docker Engine e o Docker CLI
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io

   # Remove versões antigas do Docker Compose
   sudo rm /usr/local/bin/docker-compose

   # Instala o Docker Compose
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

   echo "Docker e Docker Compose reinstalados com sucesso."

   # Exibe a versão instalada do Docker e do Docker Compose
   echo "Versão do Docker instalada:"
   docker --version

   echo "Versão do Docker Compose instalada:"
   docker-compose --version
   ```

2. **Salve o script**:
   Salve o script com um nome, por exemplo `reinstall_docker.sh`. Certifique-se de que ele esteja em um diretório onde você tenha permissão de execução.

3. **Tornar o script executável**:
   Antes de executar o script, torne-o executável com o seguinte comando:

   ```bash
   chmod +x reinstall_docker.sh
   ```

4. **Executar o script**:
   Execute o script com sudo para garantir que tenha permissões suficientes para instalar e configurar os pacotes:

   ```bash
   sudo ./reinstall_docker.sh
   ```

5. **Seguir as instruções**:
   Siga as instruções exibidas durante a execução do script para confirmar a instalação e configurar as chaves GPG necessárias.

Este script automatiza o processo de remoção das versões antigas do Docker e Docker Compose, instala as versões mais recentes e configura os binários necessários. Certifique-se de estar conectado à Internet durante a execução do script para que ele possa baixar e instalar os pacotes necessários.

Após a conclusão bem-sucedida do script, você pode verificar as versões instaladas usando `docker --version` e `docker-compose --version` para garantir que tudo tenha sido instalado corretamente.
