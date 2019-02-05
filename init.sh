#!/bin/bash
echo "Starting MYSQL"
/etc/init.d/mysql start 

echo "Staring Koha"
/etc/init.d/koha-common start 

echo "Starting apache"
/etc/init.d/apache2 start

while :; do /bin/bash; sleep 1; done
