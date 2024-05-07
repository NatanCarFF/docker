# MAPEAR DADOS DO CONTAINER
## INSPECIONAR JSON
Comando:
```
docker inspect "container"
```
## Verificar destination do json e criar pastas
Comando:
```
json: destination

mkdir /data
mkdir /data/container
```
## Especificar caminho para salvar arquivos
Comando:
```
docker run -e MYSQL_ROOT_PASSWORD=Senha123 --name "container" -d -p 3306:3306 --volume="caminho do host"ex/data/"container":"caminho do container"ex/var/lib/mysql "imagem"
```
## Conectar ao banco de dados
Comando:
```
mysql -u root -p --protocol=tcp --port=3306
```
## criar tabela no terminal
Comando:
```
create database aula;

use aula;

CREATE TABLE alunos (
    ->  AlunoID int,
    ->  Nome varchar(50),
    ->  Sobrenome varchar(50)
    ->  Endereco varchar(150)
    ->  Cidade varchar(50)
    -> );
```
## Inserir dados
Comando:
```
INSERT INTO alunos (AlunoID, Nome, Sobrenome, Endereço, Cidade) VALUES (1, 'Carlos Alberto', 'da Silva', 'Av. que sobe e desce que ninguém conhece', 'Manaus');
```
## Acessar banco de dados
Comando:
```
select * from alunos;
```
