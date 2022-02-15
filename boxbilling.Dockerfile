FROM alpine:latest as base

RUN apk --update add \
    curl \
    g++ \
    wget \
    git \
    php7 \
    php7-bcmath \
    php7-dom \
    php7-ctype \
    php7-curl \
    php7-fpm \
    php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mcrypt \
    php7-mysqlnd \
    php7-opcache \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-pdo_sqlite \
    php7-phar \
    php7-posix \
    php7-session \
    php7-soap \
    php7-xml \
    php7-xmlwriter \
    php7-simplexml \
    php7-zip \
    php7-gettext \
    php7-tokenizer \
    && rm -rf /var/cache/apk/* \
    && chmod -R 777 /var/log/php7/

RUN mkdir -p /var/www/html
RUN wget -4 https://github.com/kykurniawan/boxbilling/archive/refs/tags/v1.0.tar.gz
RUN tar -xf v1.0.tar.gz && cp -R boxbilling-1.0/* /var/www/html
RUN mkdir -p /var/www/html/bb-data/cache
RUN mkdir -p /var/www/html/bb-data/log
RUN mkdir -p /var/www/html/bb-data/uploads
RUN chmod -R 777 /var/www/html
RUN chmod -R 777 /var/www/html/bb-data/cache
RUN chmod -R 777 /var/www/html/bb-data/log
RUN chmod -R 777 /var/www/html/bb-data/uploads

COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

EXPOSE 9000

ENTRYPOINT ["php-fpm7", "-F"]


