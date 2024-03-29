# CHEAT SHEET

## Image commands
```
docker images
docker pull nginx:1.23-alpine
docker rmi nginx:1.23-alpine
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

## Samples

### Running bash in interactive tty
```
docker run --rm -it bash:5.2-alpine
# to install packages in alpine bash (ie curl)
# apk update
# apk install curl
```

### Running alpine in interactive tty
```
docker run --rm -it -- alpine:3.18 /bin/sh
```

### Running nginx in detached mode
```
docker run --rm --name my-nginx -p 8080:80 -v $(pwd)/html:/usr/share/nginx/html:ro nginx:1.23-alpine
```

### Copy files from nginx
```
docker cp my-nginx:/etc/nginx/nginx.conf nginx.conf
```

### Running node with data volume and working directory
```
docker run --rm -d -p 8080:3000 -v $(pwd)/volumes/nodejs:/var/www -w "/var/www" node:18-alpine node app.js
```

### Running redis with password
```
docker run --rm -d -p 6379:6379 redis:7-alpine --requirepass my-redis-password
docker exec -it my-redis redis-cli -a my-redis-password
```

### Running RabbitMQ with management
```
docker run --rm -d -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=my-user -e RABBITMQ_DEFAULT_PASS=my-password -e RABBITMQ_DEFAULT_VHOST=my-vhost rabbitmq:3.8-management-alpine
```

### Running Postgres
```
docker run --rm -d -p 5432:5432 -e POSTGRES_USER=my-user -e POSTGRES_PASSWORD=my-password -e POSTGRES_DB=my-database postgres:15-alpine
```





