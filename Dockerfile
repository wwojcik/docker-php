FROM alpine:latest

MAINTAINER Wojciech Wójcik <wojtaswojcik@gmail.com>

ENV TIMEZONE=Europe/Warsaw \
    MEMORY_LIMIT=256M \
    MAX_EXECUTION_TIME=180

RUN apk --update add php5-pdo \
    php5-pgsql \
    php5-mysql \
    php5-gd \
    php5-curl \
    php5-intl \
    php5-json \
    php5-xsl \
    php5-opcache \
    php5-fpm \
    php5-phar \
    php5-openssl \
    php5-zlib  \
    php5-iconv \
    php5-mcrypt \
    php5-pear \
    php5-ctype \
    php5-exif \
    php5-pdo_pgsql \
    php5-pdo_mysql \
    php5-bcmath \
    git \
    acl \
    curl \
    tzdata && \
    addgroup -S www-data && \
    adduser -D -S -G www-data www-data  && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer  && \
    rm -rf /var/cache/apk/* && \
    cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
    echo "$TIMEZONE" >  /etc/timezone

COPY config/php-fpm.conf /etc/php/php-fpm.conf

RUN sed -i "s@^;date.timezone =.*@date.timezone = $TIMEZONE@" /etc/php/php.ini \
 && sed -i "s@^memory_limit =.*@memory_limit = $MEMORY_LIMIT@" /etc/php/php.ini \
 && sed -i "s@^max_execution_time = .*@max_execution_time = $MAX_EXECUTION_TIME@" /etc/php/php.ini \
 && sed -i "s@^;always_populate_raw_post_data = .*@always_populate_raw_post_data = -1@" /etc/php/php.ini

EXPOSE 9000

VOLUME ["/app"]
WORKDIR /app
CMD ["php-fpm", "--nodaemonize"]