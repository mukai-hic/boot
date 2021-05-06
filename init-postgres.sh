#!/bin/bash
set -ex

docker pull postgres:13

sudo mkdir -p /opt/postgres

docker run -d --name postgres -v /opt/postgres:/var/lib/postgresql/data -e POSTGRES_PASSWORD=${PGPD} postgres:13

sleep 5s

docker logs postgres

docker stop postgres && docker rm postgres

