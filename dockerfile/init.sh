#!/bin/bash

/etc/init.d/mysql start && /etc/init.d/koha-common start && /etc/init.d/apache2 start

while :; do /bin/bash; sleep 1; done

