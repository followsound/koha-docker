#!/bin/bash

if [ ! -d "/koha-data/etc-koha" ]; then
  #mv /etc/kohaDefault /koha-data/etc-koha
  mv /tmp/etc-koha /koha-data/etc-koha
fi

if [ ! -d "/koha-data/mysql-data" ]; then
 #mv /var/lib/mysqlDefault /koha-data/mysql-data
 mv /tmp/mysql-data /koha-data/mysql-data
fi


/etc/init.d/mysql start && /etc/init.d/koha-common start && /etc/init.d/apache2 start


while :; do /bin/bash; sleep 1; done

