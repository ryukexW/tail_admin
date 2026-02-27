FROM php:8.3-fpm-alpine

# Cài system packages
RUN apk add --no-cache \
    bash \
    curl \
    git \
    nodejs \
    npm \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    oniguruma-dev \
    zip \
    unzip \
    autoconf \
    g++ \
    make

# Cài PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        intl \
        zip

# Copy composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .

RUN composer install

RUN npm install
RUN npm run build

RUN chown -R www-data:www-data storage bootstrap/cache

CMD ["php-fpm"]