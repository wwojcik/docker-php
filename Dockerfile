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
    php-ctype \
    git \
    && adduser -D -S -G www-data www-data \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


COPY config/php-fpm.conf /etc/php/php-fpm.conf

EXPOSE 9000

VOLUME /var/www

CMD ["php-fpm", "--nodaemonize"]