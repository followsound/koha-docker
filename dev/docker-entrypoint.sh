#!/bin/bash


xmlstarlet ed --inplace -u //config/hostname -v mysql -u //config/user -v koha_knihovna -u //config/pass -v tajneHeslo /etc/koha/sites/knihovna/koha-conf.xml 

#TODO: wait for db start...better
sleep 15
koha_db_count=`echo "use koha_knihovna; show tables;" | mysql --host=mysql --user=root --password="tajneHeslo" | wc -l`

if [ "$koha_db_count" -lt 1 ]
then
   echo "Koha database is missing"
   mysql  -p koha_knihovna --user=koha_knihovna --host=mysql --password="tajneHeslo" < /import.sql
   sed 's/ServerName .*//' /etc/apache2/sites-enabled/knihovna.conf > knihovna.conf && \
   mv knihovna.conf /etc/apache2/sites-enabled/knihovna.conf
fi

koha-create-dirs $(koha-list)
koha-start-zebra $(koha-list --enabled)
koha-start-sip $(koha-list --enabled)

if [ "$USE_INDEXER_DAEMON" = "yes" ]; then
  koha-indexer --start --quiet $(koha-list --enabled)
fi

/usr/sbin/apache2ctl -D FOREGROUND
