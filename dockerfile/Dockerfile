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


RUN /etc/init.d/mysql start; koha-create --create-db knihovna
#
## Set Apache rewrite
#RUN a2enmod rewrite
#
## Restart Apache
#RUN service apache2 restart
#
## Install Koha package
#RUN apt-get install koha-common
#
## Install MySQL server package
#RUN apt-get install mysql-server
#
#
## Create instance of Koha
#RUN koha-create --create-db knihovna
#
## Install Czech language
#RUN koha-translate –-install cs-CZ
#
#
#
###################### INSTALLATION END #####################
## Expose the default port
#EXPOSE 27017
#
## Default port to execute the entrypoint (MongoDB)
#CMD ["--port 27017"]
#
## Set default container command
#ENTRYPOINT usr/bin/mongod

