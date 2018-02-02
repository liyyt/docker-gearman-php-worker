FROM php:5
MAINTAINER Jethro Hicks <jethro@liyyt.com>

ENV PHP_EXT \
    gd \
    opcache

ENV PERSISTENT_DEPS \
    libgearman-dev \
    libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev

RUN set -xe \
    && apt-get update \
    && pecl update-channels \
    && apt-get upgrade -y \
    && apt-get install -y $PERSISTENT_DEPS \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install $PHP_EXT \
    && pecl install gearman \
    && docker-php-ext-enable gearman

CMD ["php", "-a"]
