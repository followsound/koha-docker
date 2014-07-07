# Set the base image to Debian
FROM debian:wheezy

# File Author / Maintainer
MAINTAINER opensource.knihovna.cz

RUN echo "Version: 2014062"

ENV PATH /usr/bin:/bin:/usr/sbin:/sbin
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y install vim mc wget mysql-server

ADD koha.list /etc/apt/sources.list.d/koha.list 

RUN wget -O- http://debian.koha-community.org/koha/gpg.asc | apt-key add -
RUN apt-get -y update && apt-get -y install koha-common 

RUN a2enmod rewrite

RUN sed 's/INTRAPORT="80"/INTRAPORT="8080"/' /etc/koha/koha-sites.conf > koha-sites.conf && \
    mv koha-sites.conf /etc/koha/koha-sites.conf

RUN echo "Listen 8080 " >> /etc/apache2/ports.conf

RUN /etc/init.d/mysql start; koha-create --create-db knihovna; koha-translate --install cs-CZ

RUN rm /etc/apache2/sites-enabled/000-default

RUN sed 's/ServerName .*//' /etc/apache2/sites-enabled/knihovna.conf > knihovna.conf && \
    mv knihovna.conf /etc/apache2/sites-enabled/knihovna.conf

ADD init.sh /init.sh
