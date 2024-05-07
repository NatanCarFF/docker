# APLICAÇÕES DOCKER
## Executar aplicações dentro do container
comando para criar o container e manter em execussão:
Comando:
```
docker run -dti "nome da imagem"
```
## Executar container com terminal interativo
Comando:
```
dicker exec -it "container id ou nomes" /bin/bash
```
## Atualizar dependencias do container
Comando:
```
apt update
```
Comando:
```
apt upgrade -y
```
## Instalar nano
Comando:
```
apt -y install nano
```
