FROM gliderlabs/alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV TIMEZONE Europe/Warsaw
ENV MEMORY_LIMIT 256M
# If you change MAX_EXECUTION TIME, also change fastcgi_read_timeout accordingly in nginx!
ENV MAX_EXECUTION_TIME 180

RUN apk --update add php-pdo \
    php-pgsql \
    php-mysql \
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
    php-exif \
    php-pdo_pgsql \
    php-pdo_mysql \
    git \
    acl \
    && adduser -D -S -G www-data www-data \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && rm -rf /var/cache/apk/*

COPY config/php-fpm.conf /etc/php/php-fpm.conf

RUN sed -i "s@^;date.timezone =.*@date.timezone = $TIMEZONE@" /etc/php/php.ini \
 && sed -i "s@^memory_limit =.*@memory_limit = $MEMORY_LIMIT@" /etc/php/php.ini \
 && sed -i "s@^max_execution_time = .*@max_execution_time = $MAX_EXECUTION_TIME@" /etc/php/php.ini \
 && sed -i "s@^;always_populate_raw_post_data = .*@always_populate_raw_post_data = -1@" /etc/php/php.ini

EXPOSE 9000

VOLUME ["/app"]
WORKDIR /app
CMD ["php-fpm", "--nodaemonize"]