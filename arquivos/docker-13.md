# DOCKER MOUNT BIND
## Criar container
Comando:
```
docker run -dti --mount type=bind,src=/data/debian,dst=/data debian
```
## Volume apenas para leitura
Comando:
```
docker run -dti --mount type=bind,src=data/debian,dst=data,ro debian
```
## Listar volumes
Comando:
```
docker volume ls
```
## Criar volume
Comando:
```
docker volume create data-debian
```
## Pasta padrão docker
Comando:
```
cd /var/lib/docker/
```
## Montar volume dentro do container
Comando:
```
docker run -dti --name debian --mount type=volume,src=data-debian,dst=/data debian
```
## Executar bash
Comando:
```
docker exec -ti debian bash
```
## Excluir volume
Comando:
```
docker volume rm data-debian
```
