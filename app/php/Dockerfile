ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

LABEL maintainer="bossa"

ENV GIT_SSL_NO_VERIFY true

ENV SWOOLE_VERSION 4.8.6
ENV EXT_MONGODB_VERSION 1.12.0
ENV EXT_REDIS_VERSION 5.3.6
ENV EXT_TIDEWAYS_XHPROF_VERSION 5.0.2
ENV FFMPEG_VERSION=4.2

# replace sources.list
# RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
#     && sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list

# init
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    curl \
    wget \
    zip \
    unzip \
    vim \
    vim-common \
    git \
    locales \
    procps \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libmemcached-dev \
    libtool \
    libicu-dev \
    libxml2 \
    libxml2-dev \
    libgmp3-dev \
    libevent-dev \
    libzip-dev \
    zlib1g-dev \
    libldap2-dev \
    libbz2-dev \
    libjpeg62-turbo-dev \
    libtidy-dev \
    libsqlite3-dev \
    libsqlite3-0 \
    tmux \
    keychain \
    net-tools \
    python \
    supervisor \
    cron \
    iputils-ping \
    telnet \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# install php extentions
RUN pecl channel-update pecl.php.net \
    && docker-php-ext-configure gd \
    --with-jpeg=/usr/lib \
    --with-freetype=/usr/include/freetype2 \
    # --with-zlib \
    && docker-php-ext-install -j$(nproc) dba bz2 calendar zip tidy bcmath mysqli pdo_mysql gd sockets pcntl intl soap gmp \
    # && echo "yes\ryes\r" | pecl install xlswriter \
    # && docker-php-ext-enable xlswriter \
    && pecl install msgpack \
    && docker-php-ext-enable msgpack \
    && pecl install seaslog \
    && docker-php-ext-enable seaslog \
    # && printf "\n" | pecl install apcu \
    # && docker-php-ext-enable apcu \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && pecl install redis-${EXT_REDIS_VERSION} \
    && docker-php-ext-enable redis \
    && pecl install inotify \
    && docker-php-ext-enable inotify \
    && pecl install mongodb-${EXT_MONGODB_VERSION} \
    && docker-php-ext-enable mongodb \
    # && pecl install grpc \
    # && docker-php-ext-enable grpc \
    # && pecl install protobuf \
    # && docker-php-ext-enable protobuf \
    # && echo "no\r\/usr/local/php-event/\ryes"|pecl install event \
    # && docker-php-ext-enable event \
    && pecl clear-cache \
    && echo "[finish install php]"
    # && pecl clear-cache

# install swoole extention depend hiredis
RUN wget --no-check-certificate https://github.com/swoole/swoole-src/archive/v${SWOOLE_VERSION}.zip -O swoole.zip \
    && unzip swoole.zip \
    && rm swoole.zip \
    && ( \
        cd swoole-src-${SWOOLE_VERSION} \
        && phpize \
        && ./configure --enable-mysqlnd --enable-openssl --enable-sockets --enable-http2 \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r swoole-src-${SWOOLE_VERSION} \
    && docker-php-ext-enable swoole \
    && echo "swoole.use_shortname=off" >> /usr/local/etc/php/conf.d/docker-php-ext-swoole.ini

# copy ssh key
COPY secure/ssh/ /root/.ssh/
COPY entrypoint.sh /usr/local/bin/
COPY supervisor/ /etc/supervisor/

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && service cron stop \
    && service cron start \
    && git config --global http.postBuffer 2000000000 \
    && git config --global http.sslVerify false \
    && mkdir -p /var/log/www \
    && chown -R www-data:www-data /var/log/www && chown -R www-data:www-data /var/www \
    && chmod +x /usr/local/bin/entrypoint.sh \
    && chmod -R 0600 /root/.ssh

WORKDIR /var/www/

ENTRYPOINT ["entrypoint.sh"]