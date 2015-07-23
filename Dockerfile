FROM gliderlabs/alpine:latest
MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>
RUN apk --update add php-pdo \
    php-pgsql \
    php-gd \
    php-curl \
    php-intl \
    php-json \
    php-xsl \
    php-opcache \
    php-fpm \
    php-phar \
    php-openssl \
    php-zlib  \
    php-iconv \
    php-mcrypt \
    php-pear \
    php-ctype
COPY config/php-fpm.conf /etc/php/php-fpm.conf
EXPOSE 9000
VOLUME /var/www