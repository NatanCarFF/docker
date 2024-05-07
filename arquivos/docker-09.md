# MYSQL DOCKER
## Instalar MYSQL
Comando:
```
docker pull mysql
```
## Verificar se a imagem foi baixada
Comando:
```
docker images
```
## Criar e configurar container MYSQL
Comando:
```
docker run -e MYSQL_ROOT_PASSWORD=Senha123 --name mysql -d -p 3306:3306 mysql
```
## Executar bash mysql
Comando:
```
docker exec -it mysql bash
```
## Logar dentro do container
Comando:
```
mysql -u root -p --protocol=tcp
```
Criar banco de dados
Comando:
```
CREATE DATABASE "nome";
```
## Verificar bancos criados
Comando:
```
show databases;
```
## Instalar MYSQL cliente
Comando:
```
apt -y install mysql-cliente
```
## Criando banco de dados local
Comando:
```
mysql -u root -p --protocol=tcp
```
