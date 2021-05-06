#!/bin/bash
set -ex

cat > /etc/systemd/system/postgres.service <<EOS
[Unit]
Description=Postgres Service
Requires=docker.service
After=docker.service

[Service]
ExecStartPre=-/usr/bin/sleep 3s
ExecStartPre=-/usr/bin/docker kill postgres
ExecStartPre=-/usr/bin/docker rm postgres
ExecStart=/usr/bin/docker run --name postgres -v /opt/postgres:/var/lib/postgresql/data -p 5432:5432 postgres:13
ExecStop=/usr/bin/docker stop postgres

[Install]
WantedBy=multi-user.target
EOS

systemctl daemon-reload

systemctl enable postgres.service

systemctl start postgres

