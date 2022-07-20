# CHEAT SHEET

## Image commands
```
docker images
docker pull nginx:1.21.4-alpine
docker rmi nginx:1.21.4-alpine
docker rmi -f $(docker images --all --quiet)
docker images prune
# get all image versions from docker hub registry
curl https://registry.hub.docker.com/v1/repositories/nginx/tags | jq '.[] | .name' | sed 's/"//g'
curl https://registry.hub.docker.com/v1/repositories/nginx/tags | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'
```

## Container commands
```
docker ps --all
# ef3 - first letters of container name
docker stop ef3
docker rm ef3
docker exec -it ef3 /bin/sh
# remove all containers using force
docker rm -f $(docker ps --all --quiet)
```

## Volume commands
```
docker inspect ef3 | grep -A 6 Mounts
docker rm -v ef3
```

## Custom image commands
```
docker build --tag siimp/nodejs-express:1.0.0 ./images/nodejs
docker login
docker push siimp/nodejs-express:1.0.0
```

## Docker compose commands
```
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
```
kompose convert --file ./compose/loadbalancer/docker-compose.yml --out ./compose/loadbalancer/.k8s
```

## Samples

### Running bash in interactive tty
```
docker run --rm -it bash:5.1.12-alpine
# to install packages in alpine bash (ie curl)
# apk update
# apk install curl
```

### Running alpine in interactive tty
```
docker run --rm -it -- alpine:latest /bin/sh
```

### Running nginx in detached mode
```
docker run --rm -d --name my-nginx -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html:ro nginx:1.23.1-alpine
```

### Running node with data volume and working directory
```
docker run --rm -d -p 8080:3000 -v $(pwd)/volumes/nodejs:/var/www -w "/var/www" node:17.3.0-alpine node app.js
```

### Running redis with password
```
docker run --rm -d --name my-redis -p 6379:6379 redis:6.2.7-alpine redis-server --requirepass my-redis-password
docker exec -it my-redis redis-cli -a my-redis-password
```





