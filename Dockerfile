# trusty (14.04) minimal
FROM ubuntu:trusty


# define mountable directories
VOLUME ["/data"]

# define working directory
WORKDIR /data


# Set the env variable
ENV DEBIAN_FRONTEND noninteractive
ENV REDIS_VERSION 2:2.8.17-1chl1~trusty1

COPY install.sh /
RUN bash -xe /install.sh



# RUN echo "1" >> /proc/sys/vm/overcommit_memory
# RUN sysctl vm.overcommit_memory=1


# define default command
CMD ["redis-server","/etc/redis/redis.conf"]

# expose ports
EXPOSE 6379
