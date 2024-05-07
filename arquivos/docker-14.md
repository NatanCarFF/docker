# INSTACIONAR CONTAINER DOCKER
## VERIFICAR JSON MOUNT
Comando:
```
docker inspect "container"
```
## Forçar exclusão de container
Comando:
```
docker rm -f "container"
```
## Forçar exclusão de volume
Comando:
```
docker volume rm -f "volume"
```
## Excluir todos os volumes que não estão em uso
Comando:
```
docker volume prune
```
## Excluir todos os containers
Comando:
```
docker container prune
```