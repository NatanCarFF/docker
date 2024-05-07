# DOCKER
## Acessando com ubuntu server
Comando para verificar a versão do sistema:
```
cat /etc/*release*
```
## Instalação
Link do site de instalação:
```
https://docs.docker.com/engine/install/
```
## Metodos de instalação
Link do site com os metodos de instalação para ubuntu:
```
https://docs.docker.com/engine/install/ubuntu/
```
## Instalação via script
Comando para download do script:
```
curl -fsSL https://get.docker.com -o get-docker.sh
```
Comando de execussão:
```
sh get-docker.sh
```
## Verificar versão docker
Comando para verificar versão do docker:
```
docker version
```
## Verificar se o docker está ativo
comando para verificar se o docker está ativo:
```
systemctl status docker
```
## Observações
No sistema operacional sentOS após instalação é necessário usar o comando "start docker" para que o serviço fique ativo.