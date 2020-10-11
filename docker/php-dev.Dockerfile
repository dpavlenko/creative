FROM php:7.4-fpm-alpine

RUN apk add --update --no-cache \
    autoconf \
    curl-dev \
    dpkg-dev \
    dpkg \
    freetype-dev \
    file \
    g++ \
    gcc \
    git \
    icu-dev \
    jpeg-dev \
    libc-dev \
    libmcrypt-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libxml2-dev \
    libzip-dev \
    make \
    pkgconf \
    php7-dev \
    re2c \
    rsync \
    unzip \
    wget \
    zlib-dev \
    nano

    #mariadb-dev \
    #postgresql-dev \
    #    openrc \

RUN docker-php-ext-install \
    zip \
    iconv \
    soap \
    sockets \
    intl \
    pdo_mysql \
    exif \
    pcntl    curl

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug \
    && echo xdebug.remote_enable=1 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo xdebug.remote_port=9001 >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo xdebug.remote_host=host.docker.internal >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini &&\
    apk del gcc g++ &&\
    rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


COPY --chown=www:www . /var/www/html

WORKDIR /var/www/html
