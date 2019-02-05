#!/bin/sh
docker run  -t -i -p 80:80 -p 8080:8080 --name="koha" -v /tmp:/koha-data koha /init.sh
