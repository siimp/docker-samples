# CHEAT SHEET

## Image commands
```bash
docker images
docker pull nginx:1.21.4-alpine
docker rmi nginx:1.21.4-alpine
docker rmi -f $(docker images --all --quiet)
docker images prune
```

## Container commands
```bash
docker ps --all
# ef3 - first letters of container name
docker stop ef3
docker rm ef3
docker exec -it ef3 /bin/sh
# remove all containers using force
docker rm -f $(docker ps --all --quiet)
```

## Volume commands
```bash
docker inspect ef3 | grep -A 6 Mounts
docker rm -v ef3
```

## Custom image commands
```bash
docker build --tag siimp/nodejs-express:1.0.0 ./images/nodejs
docker login
docker push siimp/nodejs-express:1.0.0
```

## Docker compose commands
```bash
docker-compose build
docker-compose up
docker-compose down
docker-compose logs
docker-compose ps
docker-compose stop
docker-compose start
# if docker-compose.yml file is not in current working directory
docker-compose -f ./compose/loadbalancer/docker-compose.yml build
docker-compose -f ./compose/loadbalancer/docker-compose.yml up --detach
```

## Kompose tool (docker compose -> kubernetes deployment)
https://github.com/kubernetes/kompose
```bash
kompose convert --file ./compose/loadbalancer/docker-compose.yml --out ./compose/loadbalancer/.k8s
```

## Samples

### Running bash in interactive tty
```bash
docker run --rm -it bash:5.1.12-alpine
# to install packages in alpine bash (ie curl)
# apk update
# apk install curl
```

### Running nginx in detached mode
```bash
docker run --rm -d -p 8080:80 nginx:1.21.4-alpine
```

### Running node with data volume and working directory
```bash
docker run --rm -d -p 8080:3000 -v $(pwd)/volumes/nodejs:/var/www -w "/var/www" node:17.3.0-alpine node app.js
```





