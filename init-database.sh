#!/bin/bash
set -ex

docker run -i --rm --add-host=docker0:${DCIP} -e PGPASSWORD=${PGPD} postgres:13 psql -h docker0 -U postgres postgres <<EOS
CREATE ROLE study
  WITH LOGIN PASSWORD '${DBPD}' CREATEDB CREATEROLE INHERIT
  ;
GRANT postgres
  TO study
  ;
CREATE DATABASE study_db WITH OWNER = study;
\q
EOS

docker run -i --rm --add-host=docker0:${DCIP} -e PGPASSWORD=${DBPD} postgres:13 psql -h docker0 -U study study_db <<EOS
CREATE SCHEMA study;
ALTER ROLE study SET search_path
  TO '$user', 'public'
  ;
\q
EOS

