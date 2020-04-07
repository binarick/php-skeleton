FROM php:7.4-fpm AS builder
RUN apt-get update
# Install COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer --quiet
ENV COMPOSER_ALLOW_SUPERUSER 1
WORKDIR /app
COPY ./composer.json ./composer.lock ./
RUN composer install --no-dev --prefer-dist --optimize-autoloader

FROM php:7.4-fpm
LABEL maintainer="Binarick <e89139139835@gmail.com>"
RUN apt-get update && apt-get install -y \
        unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install opcache
WORKDIR /app
COPY ./docker/production/defauilt.ini /usr/local/etc/php/conf.d/default.ini
COPY --from=builder /app ./
COPY ./ ./
