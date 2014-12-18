#!/bin/sh
docker stop koha-dev
docker rm koha-dev
docker stop mysql
docker rm mysql
