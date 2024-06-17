#!/bin/bash

# Atualização do sistema
sudo apt update
sudo apt upgrade -y

# Remoção de versões anteriores do Docker (opcional)
sudo apt remove -y docker docker-engine docker.io containerd runc

# Instalação de dependências
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Adição da chave GPG do Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Configuração do repositório Docker
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalação do Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Iniciar e habilitar o serviço Docker
sudo systemctl start docker
sudo systemctl enable docker

# Verificar a instalação do Docker
docker --version

# Adicionar usuário atual ao grupo docker (opcional para executar sem sudo)
sudo usermod -aG docker $USER

echo "Docker foi instalado e configurado com sucesso."
echo "Faça logout e login novamente para aplicar as alterações de grupo ou execute 'newgrp docker' para aplicar imediatamente."
