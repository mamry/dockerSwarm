# Dockerfile
FROM redis:latest
LABEL maintainer="ME"
EXPOSE 80
COPY ${WORKSPACE}/redis.conf /usr/local/etc/redis/redis.conf
