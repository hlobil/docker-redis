# trusty (14.04) minimal
FROM ubuntu:14.04.1

# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# setup repository path
RUN 	echo "deb http://archive.ubuntu.com/ubuntu $(lsb_release -cs) main universe" > /etc/apt/sources.list; \
	echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/chris-lea-redis-server.list; \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9316A7BC7917B12

# install redis server
RUN 	apt-get update -qq; \
	apt-get upgrade -qy; \
	apt-get install -qy redis-server; \
	mkdir -p /data && \
	sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
	sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
	sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
 	sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

	

# Clean up APT when done.
RUN	apt-get autoclean -qy; \
	apt-get clean -qy; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# RUN echo "1" >> /proc/sys/vm/overcommit_memory
# RUN sysctl vm.overcommit_memory=1

# define mountable directories
VOLUME ["/data"]

# define working directory.
WORKDIR /data

# define default command
CMD ["redis-server","/etc/redis/redis.conf"]

# expose ports
EXPOSE 6379

