FROM php:7.2

COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
		libfreetype6-dev \
		libjpeg62-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
        libmemcached-dev \
        wget
RUN docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir --with-jpeg-dir --with-png-dir \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install igbinary \
    && pecl install xdebug \
    && pecl install swoole \
    && docker-php-ext-enable igbinary xdebug swoole

RUN mkdir /tmp/build \
    && cd /tmp/build \
    && wget http://pecl.php.net/get/memcached-3.0.4.tgz \
    && wget https://pecl.php.net/get/redis-4.0.0.tgz \
    && tar -xvf memcached-3.0.4.tgz \
    && tar -xvf redis-4.0.0.tgz \
    && (cd /tmp/build/memcached-3.0.4 && phpize \
        && ./configure --enable-memcached --enable-memcached-igbinary --enable-memcached-json \
        && make -j$(nproc) \
        && make install \
    ) \
    && (\
        cd /tmp/build/redis-4.0.0 && phpize \
        && ./configure --enable-redis --enable-redis-igbinary \
        && make -j$(nproc) \
        && make install \
    ) \
    && docker-php-ext-enable memcached redis \
    && rm -rf /tmp/build
