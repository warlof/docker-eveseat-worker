FROM php:7.3-alpine

RUN apk add --no-cache \
    # Install OS level dependencies
    git zip unzip curl \
    libpng-dev bzip2-dev icu-dev mariadb-client && \
    # Install PHP dependencies
    docker-php-ext-install pdo_mysql gd bz2 intl pcntl

RUN apk add --no-cache $PHPIZE_DEPS && \
    pecl install redis && \
    docker-php-ext-enable redis

COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

VOLUME "/var/www/seat"
WORKDIR /var/www/seat

ENTRYPOINT ["/bin/sh", "/root/startup.sh"]
