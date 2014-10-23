#!/bin/bash

koha_db_count=`echo "show databases;" | mysql --host=mysql --user=root --password="tajneHeslo" | grep "knihovna" | wc -l`
if [ "$koha_db_count" -lt 1 ]
then
  echo "Koha database is missing"
fi

while :; do /bin/bash; sleep 1; done

