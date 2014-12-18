#!/bin/bash


xmlstarlet ed --inplace -u //config/hostname -v mysql -u //config/user -v koha_knihovna -u //config/pass -v tajneHeslo /etc/koha/sites/knihovna/koha-conf.xml 


koha_db_count=`echo "show databases;" | mysql --host=mysql --user=root --password="tajneHeslo" | grep "knihovna" | wc -l`
if [ "$koha_db_count" -lt 1 ]
then
   echo "Koha database is missing"
   #echo "CREATE DATABASE koha_knihovna;" | mysql --user=root --host=mysql --password="tajneHeslo"    
   mysql  -p koha_knihovna --user=koha_knihovna --host=mysql --password="tajneHeslo" < /import.sql
   sed 's/ServerName .*//' /etc/apache2/sites-enabled/knihovna.conf > knihovna.conf && \
   mv knihovna.conf /etc/apache2/sites-enabled/knihovna.conf
fi

