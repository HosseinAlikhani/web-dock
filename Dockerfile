FROM php:8.1-fpm
WORKDIR /var/www/docker
COPY . /var/www/docker

RUN apt-get update -y && apt-get install -y libxml2-dev libmcrypt-dev libzip-dev zip zlib1g-dev libpng-dev
# libpng-dev libjpeg-turbo-dev libwebp-dev freetype-dev
RUN docker-php-ext-configure zip
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_mysql 
RUN docker-php-ext-install soap
RUN docker-php-ext-install gd
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# EXPOSE 8000
# CMD php artisan serve --host=0.0.0.0 --port=8000
EXPOSE 9000
CMD ["php-fpm"]