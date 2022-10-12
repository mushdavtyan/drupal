FROM ubuntu:bionic

### update
RUN apt-get -q update && apt-get -q -y upgrade && apt-get -q -y dist-upgrade \
&& apt-get clean && apt-get -q update \
&& apt-get -q -y install  openssh-server git autoconf automake make \
libtool pkg-config cmake apache2 libapache2-mod-fcgid libfcgi0ldbl \
zlib1g-dev libpng-dev libjpeg-dev libtiff5-dev libgdk-pixbuf2.0-dev \
libxml2-dev libsqlite3-dev libcairo2-dev libglib2.0-dev g++ \
libmemcached-dev libjpeg-turbo8-dev && a2enmod rewrite && a2enmod fcgid

RUN mkdir /root/src
COPY . /root/src
WORKDIR /root/src

## replace apache's default fcgi config with ours.
RUN rm /etc/apache2/mods-enabled/fcgid.conf
COPY ./fcgid.conf /etc/apache2/mods-enabled/fcgid.conf

## enable proxy
RUN ln -s /etc/apache2/mods-available/proxy_http.load /etc/apache2/mods-enabled/proxy_http.load && ln -s /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/proxy.load && ln -s /etc/apache2/mods-available/proxy.conf /etc/apache2/mods-enabled/proxy.conf

## Add configuration file
COPY apache2.conf /etc/apache2/apache2.conf
COPY ports.conf /etc/apache2/ports.conf

WORKDIR /root/src


RUN git clone https://github.com/uclouvain/openjpeg.git --branch=v2.3.0 && mkdir /root/src/openjpeg/build
WORKDIR /root/src/openjpeg/build
RUN cmake -DBUILD_JPIP=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -DBUILD_CODEC=ON -DBUILD_PKGCONFIG_FILES=ON ../ && make && make install

### Openslide
WORKDIR /root/src
RUN git clone https://github.com/openslide/openslide.git

## build openslide
WORKDIR /root/src/openslide
RUN git checkout tags/v3.4.1 && autoreconf -i
RUN ./configure &&  make && make install

## iipsrv
WORKDIR /root/src/iipsrv
RUN ./autogen.sh && ./configure &&  make && mkdir -p /var/www/localhost/fcgi-bin/ && cp /root/src/iipsrv/src/iipsrv.fcgi /var/www/localhost/fcgi-bin/

#COPY apache2-iipsrv-fcgid.conf /root/src/iip-openslide-docker/apache2-iipsrv-fcgid.conf

RUN chgrp -R 0 /root && chmod -R g+rwX /root && chgrp -R 0 /var && chmod -R g+rwX /var && chgrp -R 0 /run && chmod -R g+rwX /run && chgrp -R 0 /etc/apache2 && chmod -R g+rwX /etc/apache2
USER 1001
CMD apachectl -D FOREGROUND