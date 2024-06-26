FROM php:8.3-fpm
# FROM php:8.1-fpm
# FROM php:7.4-fpm
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

# Installing Node
SHELL ["/bin/bash", "--login", "-i", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
# RUN source /root/.bashrc && nvm install 12.22.1
RUN source /root/.bashrc && nvm install 16.13 && nvm install 18.19
SHELL ["/bin/bash", "--login", "-c"]

EXPOSE 9000
CMD ["php-fpm"]