# COPIANDO ARQUIVOS DOCKER
## Comandos para criar pasta, copiar, etc
Comando para criar pasta:
```
docker exec "nome do container" mkdir /pasta
```
Comando copiar arquivo:
```
docker cp "nome do arquivo" "nome do container":/pasta
```
## Listar arquivos do container
Comando:
```
docker exec "nome do container ou id" ls /"nome da pasta" -l
```
## Instalar zip
Comando:
```
apt install -y zip
```
## Zipar arquivos
Comando:
```
zip "aquivo zipado".zip "arquivos ou *.extensão"
```
## Executar container ativo com bash
Comando:
```
docker exec -ti "nome do container ou id" /bin/bash
```
## Descompactar arquivo zip
Comando:
```
unzip "nome do arquivo".zip
```
