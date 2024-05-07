# SERVIDOR APACHE
## iNSTALAÇÃO
Comando:
```
docker pull httpd
```
## Criar pasta do apache
Comando:
```
mkdir /data/apache
```
Comando acessar:
```
cd /data/apache
```
Comando criar página:
```
nano index.html
```
Comando criar container mapeado:
```
docker run --name apache -d -p 80:80 --volume=/data/apache:/usr/local/apache2/htdocs httpd
```
## Copiar arquivo e pasta
Comando:
```
cp caminho/do/arquivo_origem caminho/do/arquivo_destino
```
Comando:
```
cp /home/usuario/documentos/arquivo.txt /home/usuario/backup
```
Comando:
```
cp -r /caminho/do/diretorio_origem /caminho/do/diretorio_destino
```
Comando:
```
cp -r /home/usuario/documentos /home/usuario/backup
```
