FROM jobalk/base
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y --allow-unauthenticated
RUN apt-get install -y php7.1 php5.6 php5.6-mysql php5.6-gettext php5.6-mbstring php7.1-xdebug libapache2-mod-php5.6 libapache2-mod-php7.1 apache2 apache2-utils mariadb-server  php5.6-xml php5.6-curl --allow-unauthenticated
RUN apt-get install -y php5.6-mysql php5.6-mcrypt php5.6-gmp php7.1-gd php5.6-gd php5.6-json php5.6-imagick php7.1-xml nodejs npm php7.1-mysql screen php5.6-imap php7.1-imap php7.1-curl --allow-unauthenticated
RUN apt-get install -y php7.1-apc php5.6-apc php7.1-intl php5.6-intl php-zmq php7.1-gd --allow-unauthenticated

COPY etc /etc
RUN chmod -R 755 /etc/service

RUN mkdir /run/mysqld && chmod -R 777 /run/mysqld
RUN a2enmod rewrite ; a2dismod php7.1 ; a2enmod php5.6 ; a2ensite default-ssl ; a2enmod ssl
RUN phpdismod -s cli xdebug
RUN rm -f /var/www/html/index.html

ADD composer-setup.php /tmp/
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer self-update

RUN npm install -g uglify-js less uglifycss

RUN ln -s /usr/local/lib/node_modules/less /usr/local/bin/less
RUN ln -s /usr/bin/nodejs /usr/local/bin/node

EXPOSE 80
EXPOSE 443
VOLUME /var/www/html
CMD ["/sbin/my_init"]

trailer_attribute_option_list_trailer_attribute
trailer_attribute_option_list_trailer_attribute_option
