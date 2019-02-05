# Set the base image to Debian
FROM debian:stretch

# File Author / Maintainer
MAINTAINER followsound.co.uk

ENV REFRESHED_AT 2019-02-05

ENV PATH /usr/bin:/bin:/usr/sbin:/sbin
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install nano mc wget mysql-server gcc gnupg

ADD koha.list /etc/apt/sources.list.d/koha.list 

RUN wget -O- http://debian.koha-community.org/koha/gpg.asc | apt-key add -
RUN apt-get -y update && apt-get -y install koha-common && /etc/init.d/koha-common stop

RUN a2enmod rewrite cgi headers proxy_http

RUN /etc/init.d/mysql start; sleep 10; koha-create --create-db clarklib; /etc/init.d/koha-common stop; /etc/init.d/apache2 stop; /etc/init.d/mysql stop; sleep 10

#RUN sed 's/ServerName .*//' /etc/apache2/sites-enabled/knihovna.conf > knihovna.conf && \
#    mv knihovna.conf /etc/apache2/sites-enabled/knihovna.conf

RUN apt-get -y install make
RUN perl -MCPAN -e 'install Data::Pagination' &&  \
    perl -MCPAN -e 'upgrade Archive::Extract' && \
    perl -MCPAN -e 'upgrade Test::WWW::Mechanize' && \
    perl -MCPAN -e 'install HTTPD::Bench::ApacheBench'
RUN ln -s /koha-data/etc-koha /etc/koha
RUN ln -s /koha-data/mysql-data /var/lib/mysql

ADD init.sh /init.sh
