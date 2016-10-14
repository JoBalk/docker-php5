FROM jobalk/base
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN add-apt-repository ppa:ondrej/php
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y --allow-unauthenticated
RUN apt-get install -y php7.0 php5.6 php5.6-mysql php5.6-gettext php5.6-mbstring php-xdebug libapache2-mod-php5.6 libapache2-mod-php7.0 apache2 apache2-utils mariadb-server  php5.6-xml php5.6-curl php5.6-mysql php5.6-mcrypt php5.6-intl php5.6-gmp php5.6-gd php5.6-json php5.6-imagick php-xml nodejs npm --allow-unauthenticated

COPY etc /etc
RUN chmod -R 755 /etc/service

RUN mkdir /run/mysqld && chmod -R 777 /run/mysqld
RUN a2enmod rewrite ; a2dismod php7.0 ; a2enmod php5.6 ; a2ensite default-ssl ; a2enmod ssl
RUN rm -f /var/www/html/index.html

RUN php composer-setup.php --install-dir=bin --filename=composer
RUN mv composer.phar /usr/local/bin/composer
RUN composer self-update

RUN npm install -g uglify-js less uglifycss

RUN export TERM=xterm

EXPOSE 80
EXPOSE 443
VOLUME /var/www/html
CMD ["/sbin/my_init"]
