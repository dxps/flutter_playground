#!/bin/sh

echo
echo ">>> Starting up the database container for FSD Blog ..."
echo 


DOCKER_CONTAINER=fsd_blog_db

docker-compose up -d

echo
echo

docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' -f name=$DOCKER_CONTAINER

echo
echo

sleep 5

docker logs $DOCKER_CONTAINER
