docker-redis
============


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/recipediary/redis/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull recipediary/redis`

### Source

- [Redis Official Repo](https://registry.hub.docker.com/_/redis/)


Usage
=====

#### Build
``` bash
docker build --rm -t recipediary/redis .
```

#### Run `redis-server`
``` bash
docker run -d \
  --name redis \
  --restart=always \
  -p 6379:6379 \
  recipediary/redis
```

#### Run `redis-server` with persistent data directory. (creates `dump.rdb`)
``` bash
docker run -d \
  --name redis
  -p 6379:6379 \
  -v <data-dir>:/data \
  recipediary/redis
```

#### Run `redis-server` with persistent data directory and password.
``` bash
docker run -d \
  --name redis \
  -p 6379:6379 \
  -v <data-dir>:/data \
  recipediary/redis redis-server /etc/redis/redis.conf --requirepass <password>
```

#### Run `redis-cli`
``` bash
docker run -it --rm \
  --link redis:redis \
  recipediary/redis bash -c 'redis-cli -h redis'
```

#### Run `backup-disk`
``` bash
docker run -it --rm  \
  --volumes-from redis \
  --link redis:redis \
  -v $(pwd):/backup \
  recipediary/redis bash -c 'cp dump.rdb /backup/dump.$(date "+%b_%d_%Y").rdb'
```
