# Shovel sample

## Build management image with shovel plugin
```
podman build -f Dockerfile --tag rabbitmq:management-shovel .
```

## Run two rabbitmq instance
```
podman network create rabbitmq-net
podman run --name rabbitmq-one --network=rabbitmq-net --rm -d -p 5672:5672 -p 15672:15672 -e RABBITMQ_DEFAULT_USER=my-user -e RABBITMQ_DEFAULT_PASS=my-password -e RABBITMQ_DEFAULT_VHOST=my-vhost rabbitmq:management-shovel
podman run --name rabbitmq-two --network=rabbitmq-net --rm -d -p 5673:5672 -p 15673:15672 -e RABBITMQ_DEFAULT_USER=my-user -e RABBITMQ_DEFAULT_PASS=my-password -e RABBITMQ_DEFAULT_VHOST=my-vhost rabbitmq:management-shovel

```

## Run applications
```
go run receive.go
```
```
go run send.go
```

## Shovel connections
```
Source:
uri:amqp://my-user:my-password@rabbitmq-one:5672/my-vhost
queue:hello

Destination
uri:amqp://my-user:my-password@rabbitmq-two:5672/my-vhost
queue:hello
```

![shovel1 settings](shovel1.PNG)