
# setup repository path
echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list;
echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu trusty main" > /etc/apt/sources.list.d/chris-lea-redis-server.list;
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9316A7BC7917B12


# install redis server
apt-get update -qq;
apt-get upgrade -qqy;
apt-get install -qqy redis-server=${REDIS_VERSION};


sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf



# Clean up APT when done.
apt-get autoclean -qy; \
apt-get clean -qy; \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
