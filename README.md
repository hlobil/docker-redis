docker-redis
============


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/hlobil/redis/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull hlobil/redis`


### Usage

#### Run `redis-server`

    docker run -d --name redis -p 6379:6379 hlobil/redis

#### Run `redis-server` with persistent data directory. (creates `dump.rdb`)

    docker run -d -p 6379:6379 -v <data-dir>:/data --name redis hlobil/redis

#### Run `redis-server` with persistent data directory and password.

    docker run -d -p 6379:6379 -v <data-dir>:/data --name redis hlobil/redis redis-server /etc/redis/redis.conf --requirepass <password>

#### Run `redis-cli`

    docker run -it --rm --link redis:redis hlobil/redis bash -c 'redis-cli -h redis'

#### Run `backup-disk`

    docker run -it --rm  \
    --volumes-from redis \
    --link redis:redis \
    -v $(pwd):/backup hlobil/redis \
    bash -c 'cp dump.rdb /backup/'

